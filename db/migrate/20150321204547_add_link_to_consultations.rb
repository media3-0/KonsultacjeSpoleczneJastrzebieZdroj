class AddLinkToConsultations < ActiveRecord::Migration
  def change
    add_column :consultations, :link, :string
  end
end
