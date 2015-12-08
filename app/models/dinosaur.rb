class Dinosaur < ActiveRecord::Base
  belongs_to :cage
  validates :name, :species, :classification, :presence => true
end
