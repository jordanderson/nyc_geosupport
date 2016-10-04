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

    assert_equal "1", nyc.response[:work_area_1][:geosupport_function_code]
    assert_equal "00", nyc.response[:work_area_1][:geosupport_return_code]

    nyc.geo_function = :basic_property
    nyc.run(house_number_display_format: "350", street_name1: "5th Ave", b10sc1: "1")

    assert_equal "00", nyc.response[:work_area_1][:geosupport_return_code]
    assert_equal({borough: "1", block: "00835", lot: "0041"}, nyc.response[:work_area_2][:bbl])
  end

  def test_extended_mode
    nyc = NycGeosupport.client(extended_mode: true, debug: true)

    nyc.run(house_number_display_format: "100", street_name1: "Broadway", b10sc1: "1")

    assert_equal 300, nyc.work_area_2.length
  end
end
