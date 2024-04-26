# frozen_string_literal: true

class AddWhatIsYourDreamToLocation < ActiveRecord::Migration[7.0]
  def change
    add_column :locations, :what_is_your_dream, :text
  end
end
