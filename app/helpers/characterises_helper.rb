# frozen_string_literal: true

module CharacterisesHelper
  def checked_characterises(area)
    @characterise.agroecology_principles_addressed.nil? ? false : @characterise.agroecology_principles_addressed.match(area)
  end

  def checked_components(area)
    @characterise.food_system_components_addressed.nil? ? false : @characterise.food_system_components_addressed.match(area)
  end
end
