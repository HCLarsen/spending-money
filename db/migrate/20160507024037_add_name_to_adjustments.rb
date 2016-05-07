class AddNameToAdjustments < ActiveRecord::Migration
  def change
    add_column :adjustments, :name, :string
  end
end
