# frozen_string_literal: true

class AddSubstitutionOfLessEcologicalAlternativeDetailsToWhatYouDo < ActiveRecord::Migration[7.0]
  def change
    add_column :what_you_dos, :substitution_of_less_ecological_alternative_details, :text
  end
end
