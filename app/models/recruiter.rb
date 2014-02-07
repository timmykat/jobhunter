class Recruiter < ActiveRecord::Base
  has_many :contacts, dependent: :destroy
  has_many :opportunities, dependent: :destroy
  has_many :events, dependent: :destroy
end
