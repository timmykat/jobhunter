class AddWeightColumnToStates < ActiveRecord::Migration
  def change
    add_column :states, :weight, :integer
  end
end
