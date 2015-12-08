class Dinosaur < ActiveRecord::Base
  belongs_to :cage
  #validates_associated :cage
  validates :name, :species, :classification, :presence => true
  validates :classification, :inclusion => {
              :in => %w(herbivore carnivore),
              :message => "%{value} is not a valid classification"
            }
end
