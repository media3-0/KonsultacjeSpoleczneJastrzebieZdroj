class AddCitizenToUser < ActiveRecord::Migration
  def change
    add_column :users, :citizen, :boolean, :default => false
  end
end
