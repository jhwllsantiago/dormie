class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string :name, null: false, default: ""
      t.string :address, null: false, default: ""
      t.string :unit, null: false, default: ""
      t.string :street, null: false, default: ""
      t.string :barangay, null: false, default: ""
      t.string :city, null: false, default: ""
      t.string :query, null: false, default: ""
      t.decimal :latitude
      t.decimal :longitude
      t.belongs_to :owner, null: false, foreign_key: true

      t.timestamps
    end

    add_index :locations, :address
    add_index :locations, :latitude
    add_index :locations, :longitude
  end
end
