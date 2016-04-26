class CreateAdjustments < ActiveRecord::Migration
  def change
    create_table :adjustments do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :frequency
      t.integer :frequency_num
      t.integer :value
      t.date :date

      t.timestamps null: false
    end
  end
end
