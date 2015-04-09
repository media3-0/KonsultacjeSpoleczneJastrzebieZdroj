ActiveAdmin.register User do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :email, :uid, :name, :image, :admin

  index do
    selectable_column
    column :email
    column :uid
    column :name
    column :image
    column :sign_in_count
    column :last_sign_in_at
    column :current_sign_in_ip
    column :last_sign_in_ip
    column :created_at
    column :admin
    actions
  end
end
