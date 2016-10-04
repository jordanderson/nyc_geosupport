module NycGeosupport

  class Client

    VERSION = "16b_16.2"
    DEFAULT_GEO_FUNCTION = :basic_blockface

    DEFAULT_INPUTS  = {
      work_area_format_indicator: "1"
    }

    attr_accessor :work_area_1, :work_area_2
    attr_reader :debug

    def initialize(options = {})
      @debug = options[:debug] || false
      @geo_function = NycGeosupport::GeoFunction.new(options[:geo_function] || DEFAULT_GEO_FUNCTION, options)
      @work_area_1 = NycGeosupport::WorkArea.new(@geo_function, {type: 1})
      @work_area_2 = NycGeosupport::WorkArea.new(@geo_function, {type: 2})
    end

    def geo_function
      @geo_function
    end

    def geo_function=(val)
      @geo_function = NycGeosupport::GeoFunction.new(val)
    end

    def run(params = {})
      if params[:geo_function].present?
        @geo_function = NycGeosupport::GeoFunction.new(params[:geo_function], params)
      end

      params_with_defaults = params.merge(DEFAULT_INPUTS)

      @work_area_1 = NycGeosupport::WorkArea.new(geo_function, params_with_defaults.merge(type: 1))
      @work_area_2 = NycGeosupport::WorkArea.new(geo_function, params_with_defaults.merge(type: 2))

      puts "Calling Geosupport using function #{geo_function.geo_function_code} with #{geo_function.extra_segments} and params #{params_with_defaults}" if @debug

      wa1_copy = work_area_1.value
      wa2_copy = work_area_2.value

      ws1 = FFI::MemoryPointer.from_string(wa1_copy)
      ws2 = FFI::MemoryPointer.from_string(wa2_copy)

      NycGeosupport.geo(ws1, ws2)

      @work_area_1.value = ws1.read_string
      @work_area_2.value = ws2.read_string

      true
    end

    def inspect
      {
        geo_function: self.geo_function.geo_function_code,
        wa1_length: self.work_area_1.length,
        wa2_length: self.work_area_2.length
      }
    end

    def response
      {
        work_area_1: work_area_1.to_h,
        work_area_2: work_area_2.to_h
      }
    end

  end
end
