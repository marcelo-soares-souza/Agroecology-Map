# frozen_string_literal: true

module LocationsHelper
  def checked_farm_and_farming_system_complement(area)
    @location.farm_and_farming_system_complement.nil? ? false : @location.farm_and_farming_system_complement.match(area)
  end
end
