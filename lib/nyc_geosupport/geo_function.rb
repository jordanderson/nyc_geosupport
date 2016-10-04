module NycGeosupport

  class GeoFunction

    DEFAULT_GEO_FUNCTION_CODE = "1"
    WORK_AREA_1_LENGTH = 1200

    GEO_FUNCTIONS = {
      "1"   => :basic_blockface,  # Blockface-related data
      "1A"  => :basic_property, # Property-related data
      "1B"  => :blockface_and_property, # Combined blockface and property-related data
      "1E"  => :blockface_and_districts, # Blockface-related data (Same as Function 1 + political districts)
      "1N"  => :normalized_street_name_code, # Normalized name/street code
      "2"   => :intersection,  # Intersection-related data
      "2W"  => :no_one_knows, # ???
      "3"   => :basic_segment, # Segment-related data + data related to left and right blockfaces
      "3C"  => :basic_blockface_redux, # Blockface-related data
      "3S"  => :street_stretch, # Street stretch-related data order along the stretch, approximate
      "AP"  => :property_cscl, # Property-related data of CSCL Address Point
      "BB"  => :browse_normalized_street_names_back, # Set of ten normalized street names in alphabetical order
      "BF"  => :browse_normalized_street_names_forward, # Set of ten normalized street names in alphabetical order
      "BL"  => :basic_property_redux, # Property-related data same as Function 1A
      "BN"  => :property_building, # Property- and building-related data
      "D"   => :normalized_primary_street_name,  # Normalized ‘primary’ name of street
      "DG"  => :normalized_principal_group_name, # Normalized ‘principal’ name of local group
      "DN"  => :normalized_street_name  # Normalized street name
    }

    GEO_FUNCTION_SYMBOLS = GEO_FUNCTIONS.invert

    GEO_FUNCTION_CONFIG = {
      "1" => {
        wa2_length: 300, long_wa2_length: nil, extended_wa2_length: 1500
      },
      "1A" => {
        wa2_length: 1364, long_wa2_length: 17750, extended_wa2_length: 2800
      },
      "1B" => {
        wa2_length: 4300
      },
      "1E" => {
        wa2_length: 300, long_wa2_length: nil, extended_wa2_length: 1500
      },
      "1N" => {},
      "BF" => {
        wa2_length: 300
      },
      "BB" => {
        wa2_length: 300
      }
    }

    # === About extended WA2 === 
    # Users may request the Extended Work Area 2 by setting the Mode Switch in Work Area 1 to ‘X’.
    # Users may request an Extended Work Area 2 for Functions 1, 1E, 1A, 3, 3C, BL and BN.
    #
    # === About Long WA2 ===
    # The COW functions that currently have the long WA2 option are functions 1A and BL.
    # The application informs Geosupport that the long WA2 is being used by inserting an ‘L’ 
    # in a WA1 input field called the Long Work Area 2 Flag.
    #
    # === About auxiliary WA2 ===
    # Similar to the ‘long WA2 option’, the ‘auxiliary segment option’ is available for COW Functions 3 and 3C.
    # Should be set to 'Y' to request auxiliary segment.
    #
    # extended WA2 and auxiliary WA2 segments can be requested at the same time. 
    # extended WA2 and long WA2 segments MAY NOT be requested at the same time

    attr_accessor :geo_function_code, :extended_mode, :long_mode, :auxiliary_mode

    # Takes a geo_function_code, symbol or string referring to one, or an instance of GeoFunction
    # and returns an instance of GeoFunction
    def initialize(function, options = {})

      case function

      when NycGeosupport::GeoFunction
        @geo_function_code = function.geo_function_code

      when String, Symbol
        if found_function = GEO_FUNCTIONS[function.to_s]
          @geo_function_code = function.to_s
        end

        if found_function = GEO_FUNCTION_SYMBOLS[function.to_sym]
          @geo_function_code = found_function
        end

      else
        raise "Input must be a String, Symbol, or GeoFunction. Received #{function.class}"

      end

      raise "Invalid geo_function: #{function}" if @geo_function_code.nil?

      @extended_mode  = options[:extended_mode].present? ? true : false
      @long_mode      = options[:long_mode].present? ? true : false
      @auxiliary_mode = options[:auxiliary_mode].present? ? true : false
    end

    def work_area_length_for_type(type)
      self.send("work_area_#{type}_length".to_sym)
    end

    def work_area_config_for_type(type)
      self.send("work_area_#{type}_config".to_sym)
    end

    def work_area_2_config
      GEO_FUNCTION_CONFIG[geo_function_code] || {}
    end

    def work_area_1_length
      WORK_AREA_1_LENGTH
    end

    def work_area_2_length
      work_area_2_config[:wa2_length]
    end

    def work_area_2_length_long
      work_area_2_config[:long_wa2_length]
    end

    def work_area_2_length_extended
      work_area_2_config[:extended_wa2_length]
    end

    def work_area_2_length_auxiliary
      work_area_2_config[:extended_wa2_length]
    end

    def extra_segments
      [
        @extended_mode ? "Extended" : nil,
        @long_mode ? "Long" : nil,
        @auxiliary_mode ? "Auxiliary" : nil,
      ].compact
    end

    def layout_class
      "#{geo_function_code}#{extra_segments.join}"
    end

    def layout_for_type(work_area_type)
      if work_area_type == 1
        NycGeosupport::Layouts::Wa1.layout
      else
        Object.const_get("NycGeosupport::Layouts::Wa#{work_area_type}#{layout_class}").send(:layout)
      end
    end

    def method_for_type(work_area_type, method_name, value)
      if work_area_type == 1
        NycGeosupport::Layouts::Wa1.send(method_name.to_sym, value)
      else
        Object.const_get("NycGeosupport::Layouts::Wa#{work_area_type}#{layout_class}").send(method_name.to_sym, value)
      end
    end

  end
end