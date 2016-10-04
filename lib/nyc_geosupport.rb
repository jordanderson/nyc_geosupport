require 'ffi'
require 'nyc_geosupport/core_ext/range'
require 'nyc_geosupport/core_ext/object'
require 'nyc_geosupport/version'
require 'nyc_geosupport/geo_function'
require 'nyc_geosupport/work_area'
require 'nyc_geosupport/client'
require 'nyc_geosupport/structures/bbl'
require 'nyc_geosupport/layouts/base'
require 'nyc_geosupport/layouts/wa1'
require 'nyc_geosupport/layouts/wa2_1'
require 'nyc_geosupport/layouts/wa2_1a'
require 'nyc_geosupport/layouts/wa2_1b'

module NycGeosupport
  extend FFI::Library
  
  ffi_lib ENV['LIBGEO_PATH'] || "/nyc_geosupport/version-16a_15.4/lib/libgeo.so"

  attach_function :geo, [:pointer, :pointer], :void

  def self.client(options = {})
    NycGeosupport::Client.new(options)
  end

end
