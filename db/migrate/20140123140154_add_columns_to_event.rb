class AddColumnsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :google_calendar_id, :string
    add_column :events, :google_event_id, :string
  end
end
