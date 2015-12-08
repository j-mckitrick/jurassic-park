class Cage < ActiveRecord::Base
  has_many :dinosaurs
  validates :max_capacity, :current_count, :power_status, :presence => true
  validates :max_capacity, :current_count, :numericality => {:only_integer => true,
                                                             :greater_than => 0}
  validate :current_count_must_fit_within_max_capacity
  validates :power_status, :inclusion => {:in => %w(active down),
                                          :message => "%{value} is not a valid power status"}

  def current_count_must_fit_within_max_capacity
    if current_count > max_capacity
      errors.add(:current_count, "Not enough room for this many dinosaurs")
    end
  end
end
