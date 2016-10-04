require 'ffi'
require 'pp'

module GeosupportLib
  extend FFI::Library
  ffi_lib "/version-16a_15.4/lib/libgeo.so"

  attach_function :geo, [:pointer, :pointer], :void
end



#wa1 = "1 100             " + "                                                  BROADWAY"+ (" " * 137) + "100000" + (" " * 981)
#wa2 = " " * 300

wa1 = "1 100             " + "                                                  BROADWAY"+ (" " * 137) + "100000" + (" " * 981)
wa2 = " " * 300

ws1 = FFI::MemoryPointer.from_string(wa1)
ws2 = FFI::MemoryPointer.from_string(wa2)

GeosupportLib.geo ws1, ws2

puts ws1.read_string
ws1.free
ws2.free

class NycGeoClient

  WA1_LENGTH = 1200
  VERSION = "16b_16.2"

  FUNCTIONS = [
    "1",  # Blockface-related data
    "1A", # Property-related data
    "1B", # Combined blockface and property-related data
    "1E", # Blockface-related data (Same as Function 1 + political districts)
    "1N", # Normalized name/street code
    "2",  # Intersection-related data
    "2W", # ???
    "3",  # Segment-related data + data related to left and right blockfaces
    "3C", # Blockface-related data
    "3S", # Street stretch-related data order along the stretch, approximate
    "AP", # Property-related data of CSCL Address Point
    "BB", # Set of ten normalized street names in alphabetical order
    "BF", # Set of ten normalized street names in alphabetical order
    "BL", # Property-related data same as Function 1A
    "BN", # Property- and building-related data
    "D",  # Normalized ‘primary’ name of street
    "DG", # Normalized ‘principal’ name of local group
    "DN"  # Normalized street name
  ]

  FUNCTION_INFO = {
    :basic_blockface => {code: "1", wa2_length: 300, long_wa2_length: nil, extended_wa2_length: 1500},
    :basic_property => {code: "1A", wa2_length: 1364, long_wa2_length: 17750, extended_wa2_length: 2800},
    :blockface_and_property => {code: "1B", wa2_length: 4300},
    :blockface_and_districts => {code: "1E", wa2_length: 300, long_wa2_length: nil, extended_wa2_length: 1500},
    :normalized_street_name_code => {code: "1N"},
    :browse_normalized_street_names_forward => {code: "BF", wa2_length: 300},
    :browse_normalized_street_names_back => {code: "BB", wa2_length: 300}
  }

  WORK_AREA_1_LAYOUT = {

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
    filler:                                 219..314,

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
    filler:                                 332..360,

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

  WORK_AREA_2_LAYOUT = {
    "1,1E" => {
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
      filler:                                     203..203,
      community_school_district:                  204..205,
      atomic_polygon:                             206..208,
      police_patrol_borough:                      209..210,
      feature_type_code:                          211..211,
      segment_type_code:                          212..212,
      alley_or_cross_street_list_flag:            213..213,
      coincidence_segment_count:                  214..214,
      filler:                                     215..216,
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
      filler:                                     263..273,
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
      filler:                                     475..481,
      street_status:                              482..482,
      street_width:                               483..485,
      street_width_irregular:                     486..486,
      bike_lane:                                  487..487,
      federal_classification_code:                488..489,
      right_of_way_type:                          490..490,
      list_of_second_set_of_lgcs:                 491..500,
      legacy_segment_id:                          501..507
    },
    "1A,BL,BN" => {
      internal_use:                               1..21,
      continuous_parity_indicator:                22..22,
      low_house_number_of_defining_address_range: 23..33,
      bbl:                                        34..43,
      tax_lot_version_filler:                     44..44,
      rpad_self_check_code_for_bbl:               45..45,
      filler:                                     46..46,
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
      filler:                                     90..90,
      dof_condo_id_number:                        91..94,
      condo_unit_id_number:                       95..101,
      condo_billing_bbl:                          102..111,
      tax_lot_version_for_billing_bbl_filler:     112..112,
      self_check_code_of_billing_bbl:             113..113,
      low_bbl_of_buildings_condo_units:           114..123,
      tax_lot_version_for_low_bbl_filler:         124..124,      
      high_bbl_of_buildings_condo_units:          125..134,
      tax_lot_version_for_high_bbl_filler:        135..135,
      filler:                                     136..150,
      cooperative_id_number:                      151..154,
      sanborn_map_identifier:                     155..162,
      dcp_commercial_study_area:                  163..167,
      tax_map_number_section_and_volume:          168..172,
      reserved_for_tax_map_page_number:           173..176,
      filler:                                     177..179,
      latitude:                                   180..188,
      longitude:                                  189..199,
      x_y_coordinates_of_tax_lot_centroid:        200..213,
      business_improvement_district:              214..219,
      tpad_bin_status:                            220..220,
      tpad_new_bin:                               221..227,
      tpad_new_bin_status:                        228..228,
      tpad_conflict_flag:                         229..229,
      filler:                                     230..238,
      list_of_4_lgcs:                             239..246,
      num_of_geographic_identifiers:              247..250,
      list_of_geographic_identifiers:             251..1363
    },
    "1B" => {
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
      filler:                                     203..203,
      community_school_district:                  204..205,
      atomic_polygon:                             206..208,
      police_patrol_borough:                      209..210,
      feature_type_code:                          211..211,
      segment_type_code:                          212..212,
      alley_or_cross_street_list_flag:            213..213,
      coincidence_segment_count:                  214..214,
      filler:                                     215..216,
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
      filler:                                     263..273,
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
      filler:                                     475..481,
      street_status:                              482..482,
      street_width:                               483..485,
      street_width_irregular:                     486..486,
      bike_lane:                                  487..487,
      federal_classification_code:                488..489,
      right_of_way_type:                          490..490,
      list_of_second_set_of_lgcs:                 491..500,
      legacy_segment_id:                          501..507,
      from_preferred_lcgs_first_set_of_5:         508..517,
      to_preferred_lcgs_first_set_of_5:           518..527,
      from_preferred_lcgs_second_set_of_5:        528..537,
      to_preferred_lcgs_second_set_of_5:          538..547,
      no_cross_street_calculation_flag:           548..548,
      individual_segment_length:                  549..553,
      nta_name:                                   554..628,
      usps_preferred_city_name:                   629..653,
      latitude:                                   654..662,
      longitude:                                  663..673,
      from_actual_segment_node_id:                674..680,
      to_actual_segment_node_id:                  681..687,
      x_coordinate_low_address_end_actual_seg:    688..694,
      y_coordinate_low_address_end_actual_seg:    695..701,
      z_coordinate_low_address_end_actual_seg:    702..708,
      x_coordinate_high_address_end_actual_seg:   709..715,
      y_coordinate_high_address_end_actual_seg:   716..722,
      z_coordinate_high_address_end_actual_seg:   723..729,
      blockface_id:                               730..739,
      number_of_travel_lanes_on_street:           740..741,
      number_of_parking_lanes_on_street:          742..743,
      number_of_total_lanes_on_street:            744..745,
      filler:                                     746..1000,
      reason_code:                                1001..1001,
      reason_code_qualifier:                      1002..1002,
      warning_code:                               1003..1004,
      return_code:                                1005..1006,
      num_of_cross_streets_at_low_address_end:    1007..1007,
      list_of_cross_streets_at_low_address_end:   1008..1047,
      num_of_cross_streets_at_high_address_end:   1048..1048,
      list_of_cross_streets_at_high_address_end:  1049..1088,
      list_of_x_street_names_at_low_address_end:  1089..1248,
      list_of_x_street_names_at_high_address_end: 1249..1408,
      boe_preferred_b7sc:                         1409..1416,
      boe_preferred_street_name:                  1417..1448,
      filler:                                     1449..1500
    }
  }

  DEFAULT_INPUTS  = {
    work_area_format_indicator: "1"
  }

  attr_accessor :work_area_1, :work_area_2, :function

  def initialize(options = {})
    @function = options[:function] || :basic_blockface

    initialize_wa1
    initialize_wa2
  end

  def set_wa1_inputs(params = {})
    params.each {|key, value|
      range = WORK_AREA_1_LAYOUT[key]
      work_area_1[range-1] = value.ljust(range.size)
    }
  end

  def run(params = {})
    initialize_wa1
    initialize_wa2

    params_with_defaults = params.merge(geosupport_function_code: FUNCTION_INFO[function][:code]).merge(DEFAULT_INPUTS)

    set_wa1_inputs(params_with_defaults)

    puts "Calling Geosupport using function #{function} (#{FUNCTION_INFO[function][:code]}) and params #{params_with_defaults}"

    return false if work_area_1.size != WA1_LENGTH
    return false if work_area_2.size != FUNCTION_INFO[function][:wa2_length]

    wa1_copy = work_area_1
    wa2_copy = work_area_2

    ws1 = FFI::MemoryPointer.from_string(wa1_copy)
    ws2 = FFI::MemoryPointer.from_string(wa2_copy)

    GeosupportLib.geo(ws1, ws2)

    @work_area_1 = ws1.read_string
    @work_area_2 = ws2.read_string

    true
  end

  def initialize_wa1
    @work_area_1 = " " * WA1_LENGTH
  end

  def initialize_wa2
    @work_area_2 = " " * FUNCTION_INFO[function][:wa2_length]
  end

  def inspect
    {
      function: function,
      wa1_length: work_area_1.size,
      wa2_length: work_area_2.size
    }
  end

  def wa1_results
    WORK_AREA_1_LAYOUT.map {|key, range|
      if range.last <= work_area_1.size
        value = work_area_1[range-1].strip
        if value.empty?
          nil
        else
          [ key,  work_area_1[range-1].strip ]
        end
      else
        nil
      end
    }.compact.to_h
  end

  def wa2_results
    WORK_AREA_2_LAYOUT["1A,BL,BN"].map {|key, range|
      if range.last <= work_area_2.size
        value = work_area_2[range-1].strip
        if value.empty?
          nil
        else
          [ key,  work_area_2[range-1].strip ]
        end
      else
        nil
      end
    }.compact.to_h
  end

end

# function and type passed in determines the work_area length and layout
# 

class WorkArea

  attr_accessor :length, :function, :type

  def initialize(params = {})

  end

  def to_h

  end

end

class Wa2Function1A < WorkArea

end

# Increment/decrement beginning and end of ranges by offset value
# Useful for converting 1-based range to 0-based range
class Range
  def +(offset)
    Range.new(self.begin + offset, self.end + offset, exclude_end?)
  end

  def -(offset)
    Range.new(self.begin - offset, self.end - offset, exclude_end?)
  end
end

n = NycGeoClient.new
n.run(house_number_display_format: "100", street_name1: "Broadway", b10sc1: "1")

n.function = :normalized_street_name_list
n.run(street_name1: "Albemarle Rd", b10sc1: "3")

n.function = :basic_property
n.run(house_number_display_format: "1701", street_name1: "Albemarle Rd", b10sc1: "3")

