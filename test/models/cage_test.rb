require 'test_helper'

class CageTest < ActiveSupport::TestCase
  default_data = { :max_capacity => 10, :current_count => 0, :power_status => 'active' }
  
  test "cannot save cage without positive integer max capacity" do
    cage = Cage.new(default_data)
    cage.max_capacity = -1
    assert_not cage.save, "Saved cage without a positive integer max capacity"
  end

  test "cannot save cage with current count greater than max capacity" do
    cage = Cage.new(default_data)
    cage.current_count = 20
    assert_not cage.save, "Saved cage with current count greater than max capacity"
  end

  # This test should break without the validator, but it does not.  Find out why.
  test "cannot save cage with invalid power status" do
    cage = Cage.new(default_data)
    cage.power_status = 'foo'
    assert_not cage.save, "Saved cage with invalid power status"
  end
end
