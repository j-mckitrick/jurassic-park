# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Cage.create(:max_capacity => 10, :power_status => "active")
Cage.create(:max_capacity => 4, :power_status => "down")

Dinosaur.create(:name => "Dino", :species => "brontosaurus", :classification => "herbivore")
Dinosaur.create(:name => "Rex", :species => "tyrannosaurus", :classification => "carnivore")
