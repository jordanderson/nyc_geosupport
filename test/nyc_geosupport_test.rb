require 'test_helper'

class NycGeosupportTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::NycGeosupport::VERSION
  end

  def test_that_client_can_be_initialized
    nyc = NycGeosupport.client

    assert_equal NycGeosupport::Client, nyc.class
  end

  def test_basic_functions
    nyc = NycGeosupport.client

    nyc.run(house_number_display_format: "100", street_name1: "Broadway", b10sc1: "1")

    puts nyc.work_area_1.geosupport_function_code

    nyc.geo_function = :basic_property
    nyc.run(house_number_display_format: "350", street_name1: "5th Ave", b10sc1: "3")

    puts n.work_area_1.to_h
    puts n.work_area_2.to_h
  end

  def test_extended_mode
    n = NycGeosupport.client(extended_mode: true, debug: true)

    n.run(house_number_display_format: "100", street_name1: "Broadway", b10sc1: "1")

  end
end
