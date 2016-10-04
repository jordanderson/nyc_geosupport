module NycGeosupport

  class WorkArea

    VALID_TYPES = [1, 2]
    DEFAULT_TYPE = 1

    attr_accessor :type

    def initialize(geo_function, options = {})
      @type = options[:type] || DEFAULT_TYPE
      @geo_function = geo_function
      if is_work_area_1?
        set_inputs(options.merge(geosupport_function_code: geo_function.geo_function_code))
      end
    end

    def value
      @value ||= (" " * @geo_function.work_area_length_for_type(type))
    end

    def value=(v)
      @value = v
    end

    def length
      value.size
    end

    def to_h
      @geo_function.layout_for_type(type).map {|key, range|
        if range.last <= value.size
          cell = value[range.as_zero_based].strip
          if cell.empty?
            nil
          else
            if result = @geo_function.method_for_type(type, key, cell) and result.present?
              [ key, result ]
            else
              [ key, cell ]
            end
          end
        else
          nil
        end
      }.compact.to_h
    end

    def set_inputs(params = {})
      working_value = value

      params.each {|key, val|
        range = @geo_function.layout_for_type(1)[key]
        if range.present? 
          working_value[range-1] = val.ljust(range.size)
        end
      }
      @value = working_value
    end

    def is_work_area_1?
      @type == 1
    end

    def is_work_area_2?
      !is_work_area_1?
    end
  end

end