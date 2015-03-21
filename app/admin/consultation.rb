
ActiveAdmin.register Consultation do
 

 permit_params :title, :file, :content, :link

form(:html => { :multipart => true }) do |f|

  f.semantic_errors
   f.inputs "Stwórz konsultację" do

     f.input :title
     f.input :content, :as => :ckeditor
     f.input :link
     f.input :file, :as => :file
     f.semantic_errors

   end
     f.actions
 end


end


 