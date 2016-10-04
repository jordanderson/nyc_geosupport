require 'test_helper'

class GeoFunctionTest < Minitest::Test
  def test_geo_function
    function = NycGeosupport::GeoFunction.new("1A")

    assert_equal "1A", function.geo_function_code
    assert_equal 1364, function.work_area_2_length
  end

  def test_nonexistent_geo_function
    assert_raises {
      function = NycGeosupport::GeoFunction.new("BLAH")
    }
  end

  def test_initializing_geo_function_from_function_code
    function = NycGeosupport::GeoFunction.new("1A")

    assert_equal "1A", function.geo_function_code
  end

  def test_initializing_geo_function_from_function_symbol
    function = NycGeosupport::GeoFunction.new(:basic_blockface)

    assert_equal "1", function.geo_function_code
  end

  def test_initializing_geo_function_from_geo_function
    function = NycGeosupport::GeoFunction.new(NycGeosupport::GeoFunction.new("1E"))

    assert_equal "1E", function.geo_function_code
  end

  def test_raising_exception_with_invalid_function_class
    assert_raises {
      function = NycGeosupport::GeoFunction.new(1)
    }
  end

  def test_layout_classes
    function = NycGeosupport::GeoFunction.new("1")
    function.layout_for_type(1)

    function = NycGeosupport::GeoFunction.new("1", extended_mode: true)
    function.layout_for_type(2)
  end
end
