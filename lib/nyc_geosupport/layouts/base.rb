module NycGeosupport

  module Layouts

    class Base

      def self.layout
      end

      def self.method_missing(method_name, value)
        nil
      end

      def self.list_of_geographic_identifiers(value)
        value.split(/\s/)
      end

      def self.bbl(value)
        NycGeosupport::Structures::BBL.new(value).to_h
      end

      def self.condo_billing_bbl(value)
        bbl(value)
      end

      def self.low_bbl_of_buildings_condo_units(value)
        bbl(value)
      end

      def self.high_bbl_of_buildings_condo_units(value)
        bbl(value)
      end

      def self.latitude(value)
        value.to_f
      end

      def self.longitude(value)
        value.to_f
      end

      def self.segment_length_in_feet(value)
        value.to_i
      end

      def self.num_of_geographic_identifiers(value)
        value.to_i
      end

      def self.number_of_structures_on_lot(value)
        value.to_i
      end

      def self.number_of_street_frontages_on_lot(value)
        value.to_i
      end

      def self.num_of_cross_streets_at_high_address_end(value)
        value.to_i
      end

      def self.num_of_cross_streets_at_low_address_end(value)
        value.to_i
      end

      def self.number_of_street_codes_and_names(value)
        value.to_i
      end

      def self.number_of_travel_lanes_on_street(value)
        value.to_i
      end

      def self.number_of_parking_lanes_on_street(value)
        value.to_i
      end

      def self.number_of_total_lanes_on_street(value)
        value.to_i
      end

    end
  end
end