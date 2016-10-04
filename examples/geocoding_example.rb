require 'nyc_geosupport'
require 'csv'

geo = NycGeosupport.client geo_function: "1A"
start_time = Time.now
count = 0

CSV.foreach("./data/addresses.csv") do |row|
  begin
    address, boro = row

    house_number, street = [address.split(" ").first, address.split(" ")[1..-1].join(" ")]
    geo.run(house_number_display_format: house_number, street_name1: street, b10sc1: boro.to_s)

    if geo.response[:work_area_1][:geosupport_return_code] == "00"
      count += 1
    end
  rescue => e
    puts "Couldn't geocode row: #{row}"
  end
end

end_time = Time.now

puts "Took #{end_time - start_time} for #{count} rows"