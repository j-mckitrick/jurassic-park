class Cage < ActiveRecord::Base
  has_many :dinosaurs
  #validates_associated :dinosaurs

  validates :max_capacity, :power_status, :presence => true
  validates :max_capacity, :numericality => {:only_integer => true,
                                             :greater_than => 0}
  validates :power_status, :inclusion => {:in => %w(active down),
                                          :message => "%{value} is not a valid power status"}

  validate :current_count_must_fit_within_max_capacity
  validate :cannot_allow_carnivores_with_herbivores
  validate :cannot_power_down_with_dinosaurs
  
  def current_count
    dinosaurs.size
  end

  def current_count_must_fit_within_max_capacity
    if current_count > max_capacity
      errors.add(:current_count, "No room for more dinosaurs")
    end
  end

  def cannot_power_down_with_dinosaurs
    if current_count > 0 && power_status == 'down'
      errors.add(:power_status, "Cannot power down with dinosaurs in a cage")
    end
  end

  def cannot_allow_carnivores_with_herbivores
    meatosaurus_present = false
    veggiesaurus_present = false
    
    dinosaurs.each do |dino|
      if dino.classification == 'carnivore'
        meatosaurus_present = true
      elsif dino.classification == 'herbivore'
        veggiesaurus_present = true
      end
    end

    puts "Check #{meatosaurus_present} #{veggiesaurus_present}"
    if meatosaurus_present && veggiesaurus_present
      errors.add(:classification, "Cannot cage herbivores with carnivores")
    end
  end

  def cannot_allow_carnivores_with_other_species_or_herbivores
    meatosaurus_present = false
    veggiesaurus_present = false
    meatosaurus_species = false
    
    dinosaurs.each do |dino|
      if dino.classification == 'carnivore'
        meatosaurus_present = true
        meatosaurus_species = dino.species
      end
    end
  end
end
