# frozen_string_literal: true

class AddIAgreeWithTermsAndConditionsToAccount < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :i_agree_with_terms_and_conditions, :boolean
  end
end
