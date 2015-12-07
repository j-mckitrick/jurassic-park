class CreateDinosaurs < ActiveRecord::Migration
  def change
    create_table :dinosaurs do |t|
      t.string :name
      t.string :species
      t.string :classification
      t.references :cage, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
