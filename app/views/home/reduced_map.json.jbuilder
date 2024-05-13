# frozen_string_literal: true

json.array!(@locations) do |location|
  json.name location.name.truncate(55)
  json.latitude  location.latitude.round(5)
  json.longitude location.longitude.round(5)
  json.url location_url(location)
  json.image_url photo_thumb_url(location, "", true)
end
