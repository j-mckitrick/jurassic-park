class DinosaurSerializer < ActiveModel::Serializer
  attributes :id, :name, :species, :classification, :cage
end
