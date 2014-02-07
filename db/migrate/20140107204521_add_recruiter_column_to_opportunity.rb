class AddRecruiterColumnToOpportunity < ActiveRecord::Migration
  def change
    add_reference :opportunities, :recruiter, index: true
  end
end
