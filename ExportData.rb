require 'open-uri'
require 'csv'
require 'prawn'
require_relative './Vehicle.rb'
require_relative './MyExceptions.rb'

class ExportData
  attr_accessor :cars

  def initialize(car_list)
    @cars = car_list.clone
  end

  def save_in_csv
    raise NilAppear.new("Cars is nil") if @cars.empty?
    CSV.open("./cars_information.csv", "a") do |csv|
      csv << ["Marka", "Model", "Rocznik", "Pojemnosc", "Rodzaj Paliwa"]
      @cars.each do |car|
        csv << [car.mark, car.version, car.year, car.capicity, car.gasoline]
      end
      puts "Generating CSV finished..."
    end
  end

  def generate_pdf
    raise NilAppear.new("Cars is nil") if @cars.empty?
    Prawn::Fonts::AFM.hide_m17n_warning = true
    pdf = Prawn::Document.new
    pdf.font "Helvetica"
    pdf.font_size 14
    i = 1
    @cars.each do |car|
      sleep(20) if i % 200 == 0
      begin
        pdf.text("#{i}) #{car}\n")
        raise NilAppear.new("Lack of img") if car.image.nil?
      rescue NilAppear => e
        pdf.text("Brak obrazka")
        if i % 2 == 0
          pdf.start_new_page
        else
          pdf.text("\n")
        end
        i += 1
        next
      else
        pdf.image URI.open("#{car.image}"), fit: [320, 240], position: :center
        if i % 2 == 0
          pdf.start_new_page
        else
          pdf.text("\n")
        end
        i += 1
      end
    end
    pdf.render_file("Otomot_offers.pdf")
    puts "Generating PDF finished..."
  end
end
