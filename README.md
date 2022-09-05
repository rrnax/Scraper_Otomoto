# Scraper_Otomoto
It's scrap informations form otomoto site. Informations like mark, model, capicity, year, kinf of gasoline and image.

ExportData.rb can export to .csv or .pdf extensions data by Vehicle class.

Exeptions are in MyExeptions.rb.

Informations about car are include in Vehicle class.

Downloading and scraping is implemented in Scraper.rb.

Unit tests are in SimpleTest.rb

You can't download more then 9 sites, because srver don't allow for it, but you can add sleep(20) to download method. It can solve this problem.
