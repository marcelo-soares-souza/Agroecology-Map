# frozen_string_literal: true


json.id @practice.id
json.name @practice.name
json.location @practice.location.name
json.responsible_for_information @practice.account.name
json.url practice_url(@practice)
json.image_url photo_thumb_url(@practice)

# what_you_do
json.where_it_is_realized @practice.what_you_do.where_it_is_realized || ""
json.summary_description @practice.what_you_do.summary_description_of_agroecological_practice ? @practice.what_you_do.summary_description_of_agroecological_practice.truncate(4096) : ""
json.practical_implementation_of_the_practice @practice.what_you_do.practical_implementation_of_the_practice || ""
json.type_of_agroecological_practice @practice.what_you_do.type_of_agroecological_practice || ""
json.why_you_use_and_what_you_expect_from_this_practice @practice.what_you_do.why_you_use_and_what_you_expect_from_this_practice || ""
json.land_size @practice.what_you_do.land_size || ""
json.substitution_of_less_ecological_alternative @practice.what_you_do.substitution_of_less_ecological_alternative || ""

# characterise
json.agroecology_principles_addressed @practice.characterise.agroecology_principles_addressed || ""
json.food_system_components_addressed @practice.characterise.food_system_components_addressed || ""

# evaluate
json.general_performance_of_practice @practice.evaluate.general_performance_of_practice || ""
json.unintended_positive_side_effects_of_practice @practice.evaluate.unintended_positive_side_effects_of_practice || ""
json.unintended_negative_side_effect_of_practice @practice.evaluate.unintended_negative_side_effect_of_practice || ""
json.knowledge_and_skills_required_for_practice @practice.evaluate.knowledge_and_skills_required_for_practice || ""
json.labour_required_for_practice @practice.evaluate.labour_required_for_practice || ""
json.cost_associated_with_practice @practice.evaluate.cost_associated_with_practice || ""
json.does_it_work_in_degraded_environments @practice.evaluate.does_it_work_in_degraded_environments || ""
json.does_it_help_restore_land @practice.evaluate.does_it_help_restore_land || ""
json.climate_change_vulnerability_effects @practice.evaluate.climate_change_vulnerability_effects || ""
json.time_requirements @practice.evaluate.time_requirements || ""
json.general_performance_of_practice_details @practice.evaluate.general_performance_of_practice_details || ""
json.unintended_positive_side_effects_of_practice_details @practice.evaluate.unintended_positive_side_effects_of_practice_details || ""
json.unintended_negative_side_effect_of_practice_details @practice.evaluate.unintended_negative_side_effect_of_practice_details || ""
json.knowledge_and_skills_required_for_practice_details @practice.evaluate.knowledge_and_skills_required_for_practice_details || ""
json.labour_required_for_practice_details @practice.evaluate.labour_required_for_practice_details || ""
json.cost_associated_with_practice_details @practice.evaluate.cost_associated_with_practice_details || ""
json.does_it_work_in_degraded_environments_details @practice.evaluate.does_it_work_in_degraded_environments_details || ""
json.does_it_help_restore_land_details @practice.evaluate.does_it_help_restore_land_details || ""
json.climate_change_vulnerability_effects_details @practice.evaluate.climate_change_vulnerability_effects_details || ""
json.time_requirements_details @practice.evaluate.time_requirements_details || ""

# acknowledge
json.practice_id @practice.acknowledge.practice_id || ""
json.knowledge_source @practice.acknowledge.knowledge_source || ""
json.knowledge_timing @practice.acknowledge.knowledge_timing || ""
json.knowledge_products @practice.acknowledge.knowledge_products || ""
json.uptake_motivation @practice.acknowledge.uptake_motivation || ""
json.knowledge_source_details @practice.acknowledge.knowledge_source_details || ""
json.knowledge_timing_details @practice.acknowledge.knowledge_timing_details || ""

json.account_id @practice.account_id
json.location_id @practice.location_id

json.created_at @practice.created_at
json.updated_at @practice.updated_at
