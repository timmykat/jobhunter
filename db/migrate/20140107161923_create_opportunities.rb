class CreateOpportunities < ActiveRecord::Migration
  def change
    create_table :opportunities do |t|
      t.string :company
      t.string :position
      t.datetime :phone_interview
      t.datetime :on_site_interview
      t.references :state, index: true

      t.timestamps
    end
  end
end
