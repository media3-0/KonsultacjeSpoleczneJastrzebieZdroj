
ActiveAdmin.register Consultation do
 

 	permit_params :title, :file, :content, :link

	form(:html => { :multipart => true }) do |f|

	  f.semantic_errors
		f.inputs "Stwórz konsultację" do

			f.input :title, :label => "Tytuł"
			f.input :content, :as => :ckeditor, :label => "Treść"
			f.input :link, :label => "Link do Google Sheets"
			f.semantic_errors

		end

		f.actions do
			f.action :submit, :label => "Stwórz konsultację"
		end
	 end


end


 