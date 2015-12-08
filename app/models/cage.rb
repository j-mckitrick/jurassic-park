class Cage < ActiveRecord::Base
  validates :max_capacity, :current_count, :power_status, :presence => true
  validates :max_capacity, :current_count, :numericality => { :only_integer => true }
  validates :power_status, :inclusion => {
              :in => %w(active down),
              :message => "%{value} is not a valid power status"
            }
end
