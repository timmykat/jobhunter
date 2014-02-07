class CreateCalendarAuths < ActiveRecord::Migration
  def change
    create_table :calendar_auths do |t|
      t.string :provider
      t.string :uid

      t.timestamps
    end
  end
end
