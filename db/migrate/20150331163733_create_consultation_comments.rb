class CreateConsultationComments < ActiveRecord::Migration
  def change
    create_table :consultation_comments do |t|
      t.string :content

      t.timestamps
    end
  end
end
