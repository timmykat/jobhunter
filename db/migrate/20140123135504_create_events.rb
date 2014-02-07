class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :type
      t.datetime :time
      t.references :opportunity, index: true
      t.references :recruiter, index: true

      t.timestamps
    end
  end
end
