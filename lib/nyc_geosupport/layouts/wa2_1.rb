module NycGeosupport

  module Layouts

    class Wa21 < NycGeosupport::Layouts::Base
      def self.layout
        {
          internal_use:                               1..21,
          continuous_parity_indicator:                22..22,
          low_house_number_of_block_face:             23..33,
          high_house_number_of_block_face:            34..44,
          dcp_preferred_lgc:                          45..46,
          num_of_cross_streets_at_low_address_end:    47..47,
          list_of_cross_streets_at_low_address_end:   48..77,
          num_of_cross_streets_at_high_address_end:   78..78,
          list_of_cross_streets_at_high_address_end:  79..108,
          borough_code:                               109..109,
          face_code:                                  110..113,
          sequence_number:                            114..118,
          special_address_generated_record_flag:      119..119,
          side_of_street_indicator:                   120..120,
          segment_length_in_feet:                     121..125,
          x_coordinate:                               126..132,
          y_coordinate:                               133..139,
          z_coordinate:                               140..146,
          community_dev_eligibility_indicator:        147..147,
          marble_hill_rikers_flag:                    148..148,
          dot_street_light_contractor_area:           149..149,
          community_district_borough_code:            150..150,
          community_district_number:                  151..152,
          zip_code:                                   153..157,
          election_district:                          158..160,
          assembly_district:                          161..162,
          split_election_district_flag:               163..163,
          congressional_district:                     164..165,
          state_senatorial_district:                  166..167,
          civil_court_district:                       168..169,
          city_council_district:                      170..171,
          health_center_district:                     172..173,
          health_area:                                174..177,
          sanitation_district:                        178..180,
          sanitation_collection_scheduling_section:   181..182,
          sanitation_regular_collection_schedule:     183..187,
          sanitation_recycling_collection_schedule:   188..190,
          police_patrol_borough_command:              191..191,
          police_precinct:                            192..194,
          fire_division:                              195..196,
          fire_battalion:                             197..198,
          fire_company_type:                          199..199,
          fire_company_number:                        200..202,
          filler3:                                    203..203,
          community_school_district:                  204..205,
          atomic_polygon:                             206..208,
          police_patrol_borough:                      209..210,
          feature_type_code:                          211..211,
          segment_type_code:                          212..212,
          alley_or_cross_street_list_flag:            213..213,
          coincidence_segment_count:                  214..214,
          filler4:                                    215..216,
          borough_of_census_tract:                    217..217,
          census_tract_1990:                          218..223,
          census_tract_2010:                          224..229,
          census_block_2010:                          230..233,
          census_block_2010_suffix:                   234..234,
          census_tract_2000:                          235..240,
          census_block_2000:                          241..244,
          census_block_2000_suffix:                   245..245,
          neighborhood_tabulation_area:               246..249,
          dsny_snow_priority_code:                    250..250,
          dsny_organic_recycling_schedule:            251..255,
          dsny_reserved:                              256..260,
          hurricane_evacuation_zone:                  261..262,
          filler5:                                    263..273,
          underlying_address_number_on_true_street:   274..284,
          underlying_b7sc_of_true_street:             285..292,
          segment_identifier:                         293..299,
          curve_flag:                                 300..300,
          list_of_4_lgcs:                             301..308,
          boe_lgc_pointer:                            309..309,
          segment_azimuth:                            310..312,
          segment_orientation:                        313..313,
          x_coordinate_low_address_end:               314..320,
          y_coordinate_low_address_end:               321..327,
          z_coordinate_low_address_end:               328..334,
          x_coordinate_high_address_end:              335..341,
          y_coordinate_high_address_end:              342..348,
          z_coordinate_high_address_end:              349..355,
          x_coordinate_segment_center:                356..362,
          y_coordinate_segment_center:                363..369,
          z_coordinate_segment_center:                370..376,
          radius_of_circle:                           377..383,
          secant_location_related_to_curve:           384..384,
          angle_to_from_node:                         385..389,
          angle_to_to_node:                           390..394,
          from_lion_node_id:                          395..401,
          to_lion_node_id:                            402..408,
          borough_code_lion:                          409..409,
          face_code_lion:                             410..413,
          sequence_number_lion:                       414..418,
          side_of_street_of_vanity_address:           419..419,
          split_low_house_number:                     420..430,
          traffic_direction:                          431..431,
          turn_restrictions:                          432..441,
          fraction_for_curve_calculation:             442..444,
          roadway_type:                               445..446,
          physical_id:                                447..453,
          generic_id:                                 454..460,
          nypd_id:                                    461..467,
          fdny_id:                                    468..474,
          filler6:                                    475..481,
          street_status:                              482..482,
          street_width:                               483..485,
          street_width_irregular:                     486..486,
          bike_lane:                                  487..487,
          federal_classification_code:                488..489,
          right_of_way_type:                          490..490,
          list_of_second_set_of_lgcs:                 491..500,
          legacy_segment_id:                          501..507
        }
      end
    end

    class Wa21Extended < NycGeosupport::Layouts::Wa21
      def self.layout
        super
      end
    end

  end
end