# == Schema Information
#
# Table name: consultations
#
#  id                :integer          not null, primary key
#  title             :string(255)
#  content           :text
#  consultation_type :integer
#  created_at        :datetime
#  updated_at        :datetime
#  formid            :string(255)
#  end_date          :datetime
#

class Consultation < ActiveRecord::Base

  has_many :consultation_comments
  validates :title, presence: true, uniqueness: true
  validates :consultation_type, :end_date, presence: true

  def self.search_query(query)
    where('title LIKE :query', query: "%#{query}%")
  end
end
