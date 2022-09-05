#UnitTests
require_relative "Scraper.rb"
require "test/unit"

class TestCode < Test::Unit::TestCase

  def test_ExceptionCheck
    assert_raise(NegativNumber) {obj = Scraper.new; obj.scrap(-2)}
    assert_nothing_raised(NegativNumber, NilAppear) {obj = Scraper.new; obj.scrap(2)}
  end

  def test_StringsTitle
    assert_not_equal("Kia Ceed", Scraper.new.split_title("Kia Ceed"), "Split doesn't work")
    assert_not_equal("Honda", Scraper.new.split_title("Honda"), "Split doesn't work")
  end

  def test_ExceptionCheck2
    assert_raise(NilAppear) {obj = Scraper.new; obj2 = ExportData.new(obj.cars); obj2.save_in_csv}
    assert_nothing_raised(NilAppear) {obj = Scraper.new; obj.scrap(2); obj2 = ExportData.new(obj.cars); obj2.save_in_csv}
  end

  def test_ExceptionCheck3
    assert_raise(NilAppear) {obj = Scraper.new;  obj2 = ExportData.new(obj.cars); obj2.generate_pdf}
    assert_nothing_raised(NilAppear) {obj = Scraper.new; obj.scrap(2);  obj2 = ExportData.new(obj.cars); obj2.generate_pdf}
  end

  def test_amount
    assert_nothing_raised(NegativNumber, NilAppear) {obj = Scraper.new; obj.scrap(1); obj2 = ExportData.new(obj.cars); obj2.save_in_csv; obj2.generate_pdf}
    assert_nothing_raised(NegativNumber, NilAppear) {obj = Scraper.new; obj.scrap(5); obj2 = ExportData.new(obj.cars); obj2.save_in_csv; obj2.generate_pdf}
    assert_nothing_raised(NegativNumber, NilAppear) {obj = Scraper.new; obj.scrap(10); obj2 = ExportData.new(obj.cars); obj2.save_in_csv; obj2.generate_pdf}
  end

end
