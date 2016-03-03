# == Schema Information
#
# Table name: consultation_comments
#
#  id                             :integer          not null, primary key
#  content                        :text
#  created_at                     :datetime
#  updated_at                     :datetime
#  user_id                        :integer
#  consultation_id                :integer
#  parent_consultation_comment_id :integer
#

class ConsultationComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :consultation

  belongs_to :consultation_comment, :foreign_key => "parent_consultation_comment_id"
  has_many :consultation_comments

  validate :have_parrent
  validates :user, :content, presence: true

  def have_parrent
    if consultation_comment != nil and consultation_comments.length > 0 then
      errors.add(:consultation_comments, "Child cannot have any children")
    end
  end

  def subcomments_count
    ConsultationComment.count_by_sql "SELECT COUNT(*) FROM consultation_comments c WHERE c.parent_consultation_comment_id = " + id.to_s
  end

  def get_subcomments
    ConsultationComment.where(:parent_consultation_comment_id => id)
  end

  rails_admin do
    edit do
      exclude_fields :consultation_comments
    end

    show do
      exclude_fields :consultation_comments
    end

    list do
      exclude_fields :consultation_comments
    end
  end
end
