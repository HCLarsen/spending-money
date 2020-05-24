class CreateAdjustments < ActiveRecord::Migration[6.0]
  def change
    create_table :adjustments do |t|
      t.string :name
      t.decimal :amount, precision: 10, scale: 2
      t.references :budget, null: false, foreign_key: true

      t.timestamps
    end
  end
end
