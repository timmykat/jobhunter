class ContactValidator < ActiveModel::Validator
  def validate(record)
    if !(record.opportunity_id.blank? ^ record.recruiter_id.blank?)
      record.errors[:base] << "A contact must be associated with a recruiter or an opportunity"
    end
  end
end

class Contact < ActiveRecord::Base
  belongs_to :opportunity
  belongs_to :recruiter
  
  validates :name, :presence => true
  
  validates_with ContactValidator
end
