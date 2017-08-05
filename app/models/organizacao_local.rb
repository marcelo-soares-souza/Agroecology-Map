class OrganizacaoLocal < ApplicationRecord
  belongs_to :organizacao
  belongs_to :local
  accepts_nested_attributes_for :organizacao, allow_destroy: true
end
