class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string :name, null: false, default: ""
      t.string :unit, null: false, default: ""
      t.string :address_line, null: false, default: ""
      t.string :city, null: false, default: ""
      t.string :province, null: false, default: ""
      t.string :full_address, null: false, default: ""
      t.string :query, null: false, default: ""
      t.decimal :latitude
      t.decimal :longitude
      t.belongs_to :owner, null: false, foreign_key: true

      t.timestamps
    end

    add_index :locations, :query
    add_index :locations, :city
    add_index :locations, :latitude
    add_index :locations, :longitude
  end
end
