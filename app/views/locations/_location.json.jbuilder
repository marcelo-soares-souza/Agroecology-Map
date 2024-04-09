# frozen_string_literal: true

json.id location.id
json.name location.name.truncate(64)
json.latitude  location.latitude.round(5)
json.longitude location.longitude.round(5)
json.url location_url(location)
json.image_url photo_thumb_url(location, "", true)
json.hide_my_location location.hide_my_location
json.account_id location.account_id
