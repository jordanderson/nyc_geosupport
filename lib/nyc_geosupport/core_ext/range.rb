module NycGeosupport

  # Increment/decrement beginning and end of ranges by offset value
  # Useful for converting 1-based range to 0-based range
  module RangeOffset
    def +(offset)
      Range.new(self.begin + offset, self.end + offset, exclude_end?)
    end

    def -(offset)
      Range.new(self.begin - offset, self.end - offset, exclude_end?)
    end

    def as_zero_based
      self - 1
    end
  end
end

Range.include NycGeosupport::RangeOffset