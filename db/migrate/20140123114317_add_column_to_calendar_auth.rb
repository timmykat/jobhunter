class AddColumnToCalendarAuth < ActiveRecord::Migration
  def change
    add_column :calendar_auths, :identity, :string
  end
end
