class ChangeColumnLengthForComments < ActiveRecord::Migration
  def change
    change_column :consultation_comments, :content,  :text
  end
end
