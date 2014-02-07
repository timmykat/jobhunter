class AddCredentialsColumnToCalendarAuth < ActiveRecord::Migration
  def change
    add_column :calendar_auths, :credentials, :text
  end
end
