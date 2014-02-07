class ChangeTableNameCalendarAuthToGoogleClient < ActiveRecord::Migration
  def change
    rename_table :calendar_auths, :google_clients
  end
end
