# frozen_string_literal: true

json.id location.id
json.name location.name
json.country location.country ? ISO3166::Country[location.country].iso_short_name : ""
json.country_code location.country || ""
json.farm_and_farming_system location.farm_and_farming_system || ""
json.farm_and_farming_system_complement location.farm_and_farming_system_complement || ""
json.description location.description || ""
# json.latitude  location.hide_my_location ? 0.0 : location.latitude
# json.longitude location.hide_my_location ? 0.0 : location.longitude
json.latitude  location.latitude
json.longitude location.longitude
json.responsible_for_information location.account.name
json.url location_url(location)
json.image_url photo_thumb_url(location)
json.image_original_url photo_original_url(location)
json.hide_my_location location.hide_my_location
json.account_id location.account_id
json.created_at location.created_at
json.updated_at location.updated_at
