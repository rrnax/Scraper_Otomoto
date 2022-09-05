require 'nokogiri'
require_relative './ExportData.rb'

class Scraper
  attr_accessor :pages
  attr_accessor :cars

  def initialize
    @pages = []
    @cars = []
  end

  def download_pages(pages_amount)
      raise NegativNumber.new("Bad amount of pages") if pages_amount <= 0
      wwwSite = "https://www.otomoto.pl/osobowe"
      1.upto(pages_amount) do |i|
        if i == 1
          @pages << Nokogiri::XML(URI.open(wwwSite))
          puts "Downloading... #{wwwSite}"
        else
          wwwPage = "#{wwwSite}?page=#{i}"
          puts "Downloading... #{wwwPage}"
          @pages << Nokogiri::XML(URI.open(wwwPage))
        end
        raise NilAppear.new("Pages content is nil") if @pages.nil?
      end
  end

  def find_information(page_no)
    raise NilAppear.new("Page is nil") if page_no.nil?

    page_no.xpath("//main//article").each do |post|
      raise NilAppear.new("Article is nil") if post.nil?
      car = Vehicle.new
      article = Nokogiri::HTML(post.to_s)
      mark_model = article.xpath("//h2//a")
      car.mark , car.version = split_title(mark_model.first.content)

      article.xpath("//ul//li").each do |feauter|
        raise NilAppear.new("Characteristick is nil") if feauter.nil?
        if feauter.content.include?("Niski przebieg") || feauter.content.include?("km")
          next
        else
          if feauter.content.include?("cm3")
            car.capicity = feauter.content
          elsif feauter.content.to_i > 1850 && feauter.content.to_i < 2050
            car.year = feauter.content
          else
            car.gasoline = feauter.content
            car.capicity = "Bateria" if feauter.content.include?("Elektryczny")
          end
        end
      end

      article.xpath("//img").each do |img|
        raise NilAppear.new("Image is nil") if img.nil?
        link = img['src']
        if link.include?("https")
          if link.include?("s=320x240") || link.include?("s=644x461")
            car.image = img['src']
          end
        end
      end
      @cars << car
    end
  end

  def split_title(title)
    begin
      space_place = title =~ / /
      if space_place.nil?
        raise NilAppear.new("Null apeears in title")
      end
    rescue NilAppear => e
        return title, " "
    else
      mark = title[0,space_place]
      version = title[space_place+1, title.length-1]
      return mark, version
    end
  end
#  protected :splitTitle, :findInformation, :downloadPages

  def scrap(pages_amount)
    download_pages(pages_amount.to_i)
    @pages.each do |page|
      find_information(page)
    end
  end

  def print_cars
    @cars.each do |car|
      puts "#{car}\n"
    end
  end

end

begin
obj = Scraper.new
obj.scrap(6)
obj2 = ExportData.new(obj.cars)
obj2.generate_pdf
obj2.save_in_csv
end
