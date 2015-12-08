require 'test_helper'

class CageTest < ActiveSupport::TestCase
  default_cage = { :max_capacity => 1, :power_status => 'active' }
  default_dino = { :name => 'Dino', :species => 'brontosaurus', :classification => 'herbivore' }
  
  test "cannot save cage without positive integer max capacity" do
    cage = Cage.new(default_cage)
    cage.max_capacity = -1
    assert_not cage.save, "Saved cage without a positive integer max capacity"
  end

  test "cannot save cage with invalid power status" do
    cage = Cage.new(default_cage)
    cage.power_status = 'foo'
    assert_not cage.save, "Saved cage with invalid power status"
  end

  test "can assign a dinosaur to a cage" do
    cage = Cage.new(default_cage)
    cage.save
    assert cage.current_count == 0, "Dino count is incorrect before assignment"
    dinosaur = Dinosaur.new(default_dino)
    dinosaur.cage = cage
    dinosaur.save
    assert cage.save, "Did not save dino to cage"
    cage.reload
    assert cage.current_count == 1, "Dino count is incorrect after assignment"
  end

  test "cannot cage carnivores with herbivores" do
    cage = Cage.new(default_cage)
    cage.save
    dinosaur = Dinosaur.new(default_dino)
    dinosaur.cage = cage
    dinosaur.save
    dinosaur = Dinosaur.new(default_dino)
    dinosaur.classification = 'carnivore'
    dinosaur.cage = cage
    dinosaur.save
    assert_not dinosaur.save, "Saves carnivore with herbivore"
  end

  test "cannot cage carnivores with other species" do
    cage = Cage.new(default_cage)
    cage.save
    assert cage.current_count == 0, "Dino count is incorrect before assignment"
    dinosaur = Dinosaur.new(default_dino)
    dinosaur.classification = 'carnivore'
    dinosaur.cage = cage
    dinosaur.save
    assert cage.save, "Did not save dino to cage"
    dinosaur = Dinosaur.new(default_dino)
    dinosaur.classification = 'carnivore'
    dinosaur.classification = 'velociraptor'
    dinosaur.cage = cage
    dinosaur.save
    # ENABLE ME
    #assert_not cage.save, "Saves carnivore with different carnivore species"
  end

  test "cannot power down cage if there are dinosaurs inside" do
    cage = Cage.new(default_cage)
    cage.save
    dinosaur = Dinosaur.new(default_dino)
    dinosaur.cage = cage
    dinosaur.save
    cage.reload
    cage.power_status = 'down'
    cage.save
    assert_not cage.save, "Powered down cage with dinosaurs inside"
  end

  test "cannot assign carnivores of different species to same cage" do
    cage = Cage.new(default_cage)
    cage.save
    dinosaur = Dinosaur.new(default_dino)
    dinosaur.cage = cage
    dinosaur.save
    assert cage.save, "Did not save dino to cage"
    cage.reload
    assert cage.current_count == 1, "Dino count is incorrect after assignment"
    dinosaur = Dinosaur.new(default_dino)
    dinosaur.cage = cage
    dinosaur.save
    assert_not cage.save, "Saves dino to cage over capacity"
    cage.reload
    # Fix this: validation must happen before dino is added
    #assert cage.current_count == 1, "Dino count is incorrect after failed assignment"
  end
end
