require 'test_helper'
require 'minitest/autorun'

class RangeOffsetTest < Minitest::Test
  def test_that_ranges_work_as_usual_on_arrays_without_offset
    an_array = [1, 2, 3, 4]
    a_range = 1..2

    assert_equal [2, 3], an_array[a_range]
  end

  def test_that_ranges_work_on_arrays_with_offset
    an_array = [1, 2, 3, 4]
    a_range = 1..2

    assert_equal [1, 2], an_array[a_range - 1]
    assert_equal [3, 4], an_array[a_range + 1]
    assert_equal [1, 2], an_array[a_range.as_zero_based]
  end

end
