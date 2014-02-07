class AddScheduleColumnsToOpportunity < ActiveRecord::Migration
  def change
    add_column :opportunities, :phone_interview_scheduled, :boolean
    add_column :opportunities, :on_site_interview_scheduled, :boolean
  end
end
