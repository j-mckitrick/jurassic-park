class CageSerializer < ActiveModel::Serializer
  attributes :id, :max_capacity, :power_status, :current_count
end
