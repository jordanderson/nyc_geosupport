module NycGeosupport
  module Structures
    class BBL

      attr_accessor :borough, :block, :lot

      def initialize(data = {})
        case data

        when String
          if data.size == 10
            @borough, @block, @lot = data[0], data[1..5], data[6..9]
          else
            raise "Invalid BBL length #{data.size}. Must be 10 characters long"
          end

        when Hash
          @borough = data[:borough]
          @block = data[:block]
          @lot = data[:lot]

        else
          raise "BBL should be initialized as a String or a Hash. Instead received #{data.class}"
        end

      end

      def to_h
        {
          borough: @borough,
          block: @block,
          lot: @lot
        }
      end

    end
  end
end