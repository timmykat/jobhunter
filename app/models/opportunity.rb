class Opportunity < ActiveRecord::Base
  belongs_to :state
  has_many :contacts, dependent: :destroy
  belongs_to :recruiter
  has_many :events, dependent: :destroy
  
  validates :company, :presence => true
  validate :recruiter_exists
  
  protected
  
  def recruiter_exists
    if Recruiter.find(self.recruiter_id).blank?
      errors.add(:recruiter_id, 'You must select a valid recruiter')
    end
  end
end
