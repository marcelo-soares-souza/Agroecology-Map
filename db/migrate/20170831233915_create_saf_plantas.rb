class CreateSafPlantas < ActiveRecord::Migration[5.1]
  def change
    create_table :saf_plantas do |t|
      t.references :saf, foreign_key: true
      t.references :planta, foreign_key: true

      t.timestamps
    end
  end
end
