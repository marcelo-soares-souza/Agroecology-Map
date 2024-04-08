# frozen_string_literal: true

json.id location.id
json.name location.name
json.latitude  location.latitude
json.longitude location.longitude
json.url location_url(location)
json.image_url photo_thumb_url(location, "", true)
json.hide_my_location location.hide_my_location
json.account_id location.account_id
