# frozen_string_literal: true

json.id practice.id
json.name practice.name
json.summary_description practice.what_you_do.summary_description_of_agroecological_practice ? practice.what_you_do.summary_description_of_agroecological_practice.truncate(512) : ""
json.location practice.location.name
json.responsible_for_information practice.account.name
json.url practice_url(practice)
json.image_url photo_thumb_url(practice)
json.account_id practice.account_id
json.location_id practice.location_id
json.created_at practice.created_at
json.updated_at practice.updated_at
