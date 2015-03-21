class AddFilesToConsultations < ActiveRecord::Migration
  def change
    add_column :consultations, :files, :string
  end
end
