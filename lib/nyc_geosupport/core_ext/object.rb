# As in ActiveSupport, but no need for the dependency

module NycGeosupport
  module Presence
    def blank?
      respond_to?(:empty?) ? !!empty? : !self
    end

    def present?
      !blank?
    end
  end
end

Object.include NycGeosupport::Presence