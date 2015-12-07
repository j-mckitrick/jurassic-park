class CreateCages < ActiveRecord::Migration
  def change
    create_table :cages do |t|
      t.integer :max_capacity
      t.integer :current_count
      t.string :power_status

      t.timestamps null: false
    end
  end
end
