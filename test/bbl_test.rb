require 'test_helper'

class BBLTest < Minitest::Test
  def test_that_bbl_can_be_created_from_string
    bbl = NycGeosupport::Structures::BBL.new("1234567890")

    assert_equal "1", bbl.borough
    assert_equal "23456", bbl.block
    assert_equal "7890", bbl.lot
  end

  def test_that_bbl_can_be_created_from_hash
    bbl = NycGeosupport::Structures::BBL.new(borough: "5", block: "74837", lot: "7634")

    assert_equal "5", bbl.borough
    assert_equal "74837", bbl.block
    assert_equal "7634", bbl.lot

    blank_bbl = NycGeosupport::Structures::BBL.new

    assert_equal nil, blank_bbl.borough
  end

end
