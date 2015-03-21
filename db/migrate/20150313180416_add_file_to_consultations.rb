class AddFileToConsultations < ActiveRecord::Migration
  def change
    add_column :consultations, :file, :string
  end
end
