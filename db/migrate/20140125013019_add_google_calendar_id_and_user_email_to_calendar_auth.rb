class AddGoogleCalendarIdAndUserEmailToCalendarAuth < ActiveRecord::Migration
  def change
    add_column :calendar_auths, :google_calendar_id, :string
    add_column :calendar_auths, :user_email, :string
  end
end
