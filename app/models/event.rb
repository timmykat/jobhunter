class EventValidator < ActiveModel::Validator
  def validate(record)
    if !(record.opportunity_id.blank? ^ record.recruiter_id.blank?)
      record.errors[:base] << "An event must be associated with an opportunity or a recruiter"
    end
  end
end

class Event < ActiveRecord::Base
  belongs_to :opportunity
  belongs_to :recruiter
  
  # Event.validators_on(:type)[0].options[:in]
  validates :event_type, inclusion: { in: ['Phone interview', 'On-site interview', 'Code exercise'] }
  validates_with EventValidator
end
