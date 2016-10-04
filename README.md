# NycGeosupport

New York City is kind enough to publish their [Geosupport Desktop Edition](https://www1.nyc.gov/site/planning/data-maps/open-data/dwn-gde-home.page) shared object library and data, along with a voluminous [User Programming Guide](http://www1.nyc.gov/assets/planning/download/pdf/data-maps/open-data/upg.pdf) demonstrating how to use it. This toolset allows you to build a super-fast (at the moment, I can geocode 2,000 addresses per second on a docker machine running on my Mac) NYC geocoder for your application without needing outside network access.

NycGeosupport is a ruby gem that makes use of the [ffi](https://github.com/ffi/ffi) gem to wrap a more pleasant API around Geosupport Desktop Edition -- more pleasant if you find writing ruby more pleasant than C anyway ;). 


## Usage

NOTE: I could be mistaken, but this will not run on your non-Linux machine, because the shared object libraries contained in the Geosupport Desktop Edition are built on Linux. However, if you're running MacOS (like me) or Windows then [Docker](https://docs.docker.com) to the rescue! (Though I guess if you're running Windows there is a native version of Geosupport Desktop Edition already.) 

The Rakefile in this repository has some helpful rake commands for building, testing, and running the nyc_geosupport gem inside a docker container:  
```
rake image:build     # Build Docker image
rake image:cleanup   # Delete untagged Docker images (uses --force so be careful)
rake image:list      # List nyc_geosupport Docker images 
rake docker:console  # Run console in Docker container with nyc_geosupport gem loaded
rake docker:test     # Run tests in Docker container
```

`rake image:build` will download and extract geosupport desktop edition and set the ENV vars needed for geosupport. Several of those ENV vars are required for geosupport internally, but LIBGEO_PATH is used by the gem as the location of the libgeo.so file.

Use `rake docker:console` to run an interactive console inside your docker machine with the gem built and loaded.

Use `rake docker:test` to run tests on the gem inside your docker machine.

Note that `docker:test` and `docker:console` both call `image:build` as a first step. That step builds and installs the gem in your docker machine. 

Here's an example of calling a geosupport function in the console:

```
> nyc = NycGeosupport.client(geo_function: "1")
=> {:geo_function=>"1", :wa1_length=>1200, :wa2_length=>300}

> nyc.run(house_number_display_format: "100", street_name1: "Broadway", b10sc1: "1")
=> true

> nyc.response
=> {:work_area_1=>{:geosupport_function_code=>"1", :house_number_display_format=>"100", :b10sc1=>"1", :street_name1=>"BROADWAY", :work_area_format_indicator=>"1", :first_borough_name=>"MANHATTAN", :house_number_display_format_output=>"100", :house_number_sort_format_output=>"000100000AA", :b10sc_first_borough_and_street_code=>"11361001010", :first_street_name_normalized=>"BROADWAY", :geosupport_return_code=>"00"},

:work_area_2=>{:internal_use=>"011136102000102000AA", :low_house_number_of_block_face=>"000092000AA", :high_house_number_of_block_face=>"000102000AA", :dcp_preferred_lgc=>"01", :num_of_cross_streets_at_low_address_end=>1, :list_of_cross_streets_at_low_address_end=>"132910", :num_of_cross_streets_at_high_address_end=>1, :list_of_cross_streets_at_high_address_end=>"128870", :borough_code=>"1", :face_code=>"0755", :sequence_number=>"01055", :side_of_street_indicator=>"R", :segment_length_in_feet=>236, :x_coordinate=>"0981097", :y_coordinate=>"0197271", :community_dev_eligibility_indicator=>"I", :dot_street_light_contractor_area=>"1", :community_district_borough_code=>"1", :community_district_number=>"01", :zip_code=>"10005", :election_district=>"092", :assembly_district=>"65", :health_center_district=>"15", :health_area=>"7700", :sanitation_district=>"101", :police_patrol_borough_command=>"1", :police_precinct=>"001", :fire_division=>"01", :fire_battalion=>"01", :fire_company_type=>"E", :fire_company_number=>"004", :community_school_district=>"02", :atomic_polygon=>"304", :police_patrol_borough=>"MS", :segment_type_code=>"U", :coincidence_segment_count=>"1", :borough_of_census_tract=>"1", :census_tract_1990=>"7", :census_tract_2010=>"7", :census_block_2010=>"1006", :census_tract_2000=>"7", :census_block_2000=>"3003", :neighborhood_tabulation_area=>"MN25", :dsny_snow_priority_code=>"P", :hurricane_evacuation_zone=>"5", :underlying_b7sc_of_true_street=>"11361001", :segment_identifier=>"0114275"}}
```

As you can see, you can instantiate a geosupport client with `NycGeosupport.client` and use the `run` method to query geosupport. The response can be viewed as a Hash by calling the response method.

For some other examples, check out [nyc_geosupport_test.rb](https://github.com/jordanderson/nyc_geosupport/blob/master/test/nyc_geosupport_test.rb). 


## To Do
- Finish work area 2 layouts
- Error/exception handling
- More tests
- Better responses than just a Hash
- Documentation


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jordanderson/nyc_geosupport.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

