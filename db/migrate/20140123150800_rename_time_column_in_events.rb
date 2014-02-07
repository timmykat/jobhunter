class RenameTimeColumnInEvents < ActiveRecord::Migration
  def change
    rename_column :events, :time, :event_time
  end
end
