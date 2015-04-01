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
end
