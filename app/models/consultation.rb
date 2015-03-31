class Consultation < ActiveRecord::Base

  has_many :consultation_comments
  validates :title, presence: true, uniqueness: true
  validates :consultation_type, presence: true
	
end
