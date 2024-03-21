# frozen_string_literal: true

class AddDetailsToAcknowledge < ActiveRecord::Migration[7.0]
  def change
    add_column :acknowledges, :knowledge_source_details, :text
    add_column :acknowledges, :knowledge_timing_details, :text
  end
end
