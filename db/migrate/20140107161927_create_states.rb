class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :state
      t.references :opportunity, index: true
    end
  end
end
