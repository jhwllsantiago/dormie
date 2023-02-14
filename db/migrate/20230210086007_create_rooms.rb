class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.string :name, null: false, default: ""
      t.text :description, null: false, default: ""
      t.float :rent, null: false, default: 0.0
      t.integer :capacity, null: false, default: 0
      t.integer :vacancies, null: false, default: 0
      t.string :tags, array: true
      t.belongs_to :location, null: false, foreign_key: true

      t.timestamps
    end

    add_index :rooms, :name
    add_index :rooms, :rent
    add_index :rooms, :tags
  end
end
