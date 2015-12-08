class Cage < ActiveRecord::Base
  validates :max_capacity, :current_count, :power_status, :presence => true
end
