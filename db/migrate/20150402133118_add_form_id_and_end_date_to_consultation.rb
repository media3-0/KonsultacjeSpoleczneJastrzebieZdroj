class AddFormIdAndEndDateToConsultation < ActiveRecord::Migration
  def change
    add_column :consultations, :formid, :string
    add_column :consultations, :end_date, :datetime
  end
end
