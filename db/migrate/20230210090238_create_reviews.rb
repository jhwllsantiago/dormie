class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.integer :rating, null: false, default: 5
      t.string :title, null: false, default: ""
      t.text :comment, null: false, default: ""
      t.belongs_to :room, null: false, foreign_key: true
      t.belongs_to :occupant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
