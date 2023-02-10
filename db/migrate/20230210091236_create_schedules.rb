class CreateSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :schedules do |t|
      t.boolean :mon, array: true
      t.boolean :tue, array: true
      t.boolean :wed, array: true
      t.boolean :thu, array: true
      t.boolean :fri, array: true
      t.boolean :sat, array: true
      t.boolean :sun, array: true
      t.belongs_to :owner, null: false, foreign_key: true

      t.timestamps
    end
  end
end
