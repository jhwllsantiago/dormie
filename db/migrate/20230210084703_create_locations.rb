class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string :name, null: false, default: ""
      t.string :address, null: false, default: ""
      t.string :barangay, null: false, default: ""
      t.string :city, null: false, default: ""
      t.decimal :long, :precision => 10, :scale => 6
      t.decimal :lat, :precision => 10, :scale => 6

      t.timestamps
    end

    add_index :locations, :name
    add_index :locations, :city
  end
end
