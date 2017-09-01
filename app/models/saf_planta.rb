class SafPlanta < ApplicationRecord
  belongs_to :saf
  belongs_to :planta
  accepts_nested_attributes_for :saf, allow_destroy: true
end
