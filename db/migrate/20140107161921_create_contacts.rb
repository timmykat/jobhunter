class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :title
      t.string :email
      t.string :phone
      t.date :last_contact
      t.references :opportunity, index: true
      t.references :recruiter, index: true

      t.timestamps
    end
  end
end
