# frozen_string_literal: true

json.id practice.id
json.name practice.name
json.description practice.what_you_do.summary_description_of_agroecological_practice
json.where_it_is_realized practice.what_you_do.where_it_is_realized
json.agroecology_principles_invoked practice.characterise.agroecology_principles_addressed
json.food_system_components_addressed practice.characterise.food_system_components_addressed
json.url practice_url(practice)
json.image_url photo_thumb_url(practice, "", true)
json.location_name practice.location.name
json.responsible_for_information practice.account.name
json.account_id practice.account.id
json.location_id practice.location_id
json.created_at practice.created_at
json.updated_at practice.updated_at
