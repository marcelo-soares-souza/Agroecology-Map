# frozen_string_literal: true

class AddUnitOfMeasureToWhatYouDo < ActiveRecord::Migration[7.0]
  def change
    add_column :what_you_dos, :unit_of_measure, :string
  end
end
