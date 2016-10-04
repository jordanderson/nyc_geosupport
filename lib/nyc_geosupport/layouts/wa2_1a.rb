module NycGeosupport

  module Layouts

    class Wa21A < NycGeosupport::Layouts::Base
      def self.layout
        {
          internal_use:                               1..21,
          continuous_parity_indicator:                22..22,
          low_house_number_of_defining_address_range: 23..33,
          bbl:                                        34..43,
          tax_lot_version_filler:                     44..44,
          rpad_self_check_code_for_bbl:               45..45,
          filler7:                                    46..46,
          rpad_building_classification_code:          47..48,
          corner_code:                                49..50,
          number_of_structures_on_lot:                51..54,
          number_of_street_frontages_on_lot:          55..56,
          interior_lot_flag:                          57..57,
          vacant_lot_flag:                            58..58,
          irregularly_shaped_lot_flag:                59..59,
          marble_hill_rikers_flag:                    60..60,
          list_of_geographic_ids_overflow_flag:       61..61,
          strolling_key:                              62..80,
          reserved_for_internal_use:                  81..81,
          bin_of_input_address:                       82..88,
          condo_flag:                                 89..89,
          filler8:                                    90..90,
          dof_condo_id_number:                        91..94,
          condo_unit_id_number:                       95..101,
          condo_billing_bbl:                          102..111,
          tax_lot_version_for_billing_bbl_filler:     112..112,
          self_check_code_of_billing_bbl:             113..113,
          low_bbl_of_buildings_condo_units:           114..123,
          tax_lot_version_for_low_bbl_filler:         124..124,      
          high_bbl_of_buildings_condo_units:          125..134,
          tax_lot_version_for_high_bbl_filler:        135..135,
          filler9:                                    136..150,
          cooperative_id_number:                      151..154,
          sanborn_map_identifier:                     155..162,
          dcp_commercial_study_area:                  163..167,
          tax_map_number_section_and_volume:          168..172,
          reserved_for_tax_map_page_number:           173..176,
          filler10:                                   177..179,
          latitude:                                   180..188,
          longitude:                                  189..199,
          x_y_coordinates_of_tax_lot_centroid:        200..213,
          business_improvement_district:              214..219,
          tpad_bin_status:                            220..220,
          tpad_new_bin:                               221..227,
          tpad_new_bin_status:                        228..228,
          tpad_conflict_flag:                         229..229,
          filler11:                                   230..238,
          list_of_4_lgcs:                             239..246,
          num_of_geographic_identifiers:              247..250,
          list_of_geographic_identifiers:             251..1363
        }
      end
    end
  end
end