class Vehicle
attr_accessor :mark
attr_accessor :version
attr_accessor :year
attr_accessor :capicity
attr_accessor :gasoline
attr_accessor :milege
attr_accessor :image

def initialize
  @mark = "Brak"
  @version = "Brak"
  @year = "Brak"
  @capicity = "Brak"
  @gasoline = "Brak"
  @milege = "Brak"
  @image = "Brak"
end

def to_s
  "Marka: #@mark\nModel: #@version\nRok: #@year\nPojemnosc: #@capicity\nPaliwo: #@gasoline\n\n"
end

end
