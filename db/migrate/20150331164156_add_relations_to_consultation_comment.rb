class AddRelationsToConsultationComment < ActiveRecord::Migration
  def change
    add_column :consultation_comments, :user_id, :integer
    add_column :consultation_comments, :consultation_id, :integer
    add_column :consultation_comments, :parent_consultation_comment_id, :integer
  end
end
