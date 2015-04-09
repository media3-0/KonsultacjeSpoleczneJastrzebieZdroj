class RemoveLinkFromConsultations < ActiveRecord::Migration
  def change
    remove_column :consultations, :link
  end
end
