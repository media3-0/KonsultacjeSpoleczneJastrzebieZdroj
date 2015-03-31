class FixColumnTypeName < ActiveRecord::Migration
  def change
    rename_column :consultations, :type, :consultation_type
  end
end
