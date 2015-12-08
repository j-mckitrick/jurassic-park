class CageSerializer < ActiveModel::Serializer
  attributes :id, :max_capacity, :power_status
end
