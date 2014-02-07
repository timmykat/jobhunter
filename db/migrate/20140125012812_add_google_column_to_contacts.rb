class AddGoogleColumnToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :google_contact_id, :string
  end
end
