class CageSerializer < ActiveModel::Serializer
  attributes :id, :max_capacity, :current_count, :power_status
end
