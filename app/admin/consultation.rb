
ActiveAdmin.register Consultation do
 

 	permit_params :title, :content, :end_date, :formid, :consultation_type

	form(:html => { :multipart => true }) do |f|

	  f.semantic_errors
		f.inputs 'Stwórz konsultację' do

			f.input :title, :label => 'Tytuł'
			f.input :content, :as => :rich, :config => {width: '76%', height: '400px', removeDialogTabs: ''}, :label => 'Treść'
      f.input :consultation_type, :as => :radio, :collection => {Aktualne: 0, Planowane: 1, Zakończone: 2}, :label => 'Typ'
      f.input :end_date, :label => 'Zakończenie konsultacji'
			f.input :formid, :label => 'Id formularza google'
			f.semantic_errors

		end

		f.actions do
			f.action :submit, :label => 'Stwórz konsultację'
		end
	 end


end


 