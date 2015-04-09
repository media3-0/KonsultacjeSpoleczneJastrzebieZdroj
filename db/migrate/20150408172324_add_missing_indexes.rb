class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :consultation_comments, :user_id
    add_index :consultation_comments, :consultation_id
    add_index :consultation_comments, :parent_consultation_comment_id
  end
end