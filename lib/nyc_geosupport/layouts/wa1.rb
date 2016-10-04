module NycGeosupport

  module Layouts

    class Wa1 < NycGeosupport::Layouts::Base
      def self.layout
        {
          # Input fields
          geosupport_function_code:               1..2,
          house_number_display_format:            3..18,
          house_number_sort_format:               19..29,
          low_house_number_display_format:        30..45,
          low_house_number_sort_format:           46..56,
          b10sc1:                                 57..67,
          street_name1:                           68..99,
          b10sc2:                                 100..110,
          street_name2:                           111..142,
          b10sc3:                                 143..153,
          street_name3:                           154..185,
          bbl:                                    186..195,
          tax_lot_version_filler:                 196..196,
          bin:                                    197..203,
          compass_direction:                      204..204,
          compass_direction_2_intersection:       205..205,
          node_number:                            206..212,
          work_area_format_indicator:             213..213,
          zip_code_input:                         214..218,
          filler1:                                219..314,

          # Input flags
          long_work_area_2_flag:                  315..315,
          house_number_just_flag:                 316..316,
          house_number_normalization_len:         317..318,
          house_number_normalization_override:    319..319,
          street_name_normalization_length_limit: 320..321,
          street_name_normalization_format_flag:  322..322,
          cross_street_names_flag:                323..323,
          roadbed_request_switch:                 324..324,
          internal_grc_flag:                      325..325,
          auxiliary_segment_switch:               326..326,
          browse_flag:                            327..327,
          real_streets_only_flag:                 328..328,
          tpad_switch:                            329..329,
          mode_switch:                            330..330,
          wto_switch:                             331..331,
          filler2:                                332..360,

          # Output fields
          first_borough_name:                     361..369,
          house_number_display_format_output:     370..385,
          house_number_sort_format_output:        386..396,
          b10sc_first_borough_and_street_code:    397..407,
          first_street_name_normalized:           408..439,
          b10sc_second_borough_and_street_code:   440..450,
          second_street_name_normalized:          451..482,
          b10sc_third_borough_and_street_code:    483..493,
          third_street_name_normalized:           494..525,
          bbl_output:                             526..535,
          tax_lot_version_filler_output:          536..536,
          low_house_number_display_format_output: 537..552,
          low_house_number_sort_format_output:    553..563,
          bin_output:                             564..570,
          street_attribute_indicators:            571..573,
          reason_code_2:                          574..574,
          reason_code_qualifier_2:                575..575,
          warning_code_2:                         576..577,
          geosupport_return_code_2:               578..579,
          message_2:                              580..659,
          node_number_output:                     660..666,
          filler_output:                          667..705,
          nin:                                    706..711,
          street_attribute_indicator:             712..712,
          reason_code:                            713..713,
          reason_code_qualifier:                  714..714,
          warning_code:                           715..716,
          geosupport_return_code:                 717..718,
          message:                                719..798,
          number_of_street_codes_and_names:       799..800,
          list_of_street_codes:                   801..880,
          list_of_street_names:                   881..1200
        }
      end
    end
  end
end