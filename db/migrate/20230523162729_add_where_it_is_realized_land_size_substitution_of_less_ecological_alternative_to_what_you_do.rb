# frozen_string_literal: true

class AddWhereItIsRealizedLandSizeSubstitutionOfLessEcologicalAlternativeToWhatYouDo < ActiveRecord::Migration[7.0]
  def change
    add_column :what_you_dos, :where_it_is_realized, :string
    add_column :what_you_dos, :land_size, :float
    add_column :what_you_dos, :substitution_of_less_ecological_alternative, :string
  end
end
