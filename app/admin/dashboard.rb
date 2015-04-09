ActiveAdmin.register_page 'Dashboard' do

  menu priority: 1, label: proc{ 'Panel Administratora' }

  content title: proc{ 'Panel Administratora' } do
    div class: 'blank_slate_container', id: 'dashboard_default_message' do
      span class: 'blank_slate' do
        span 'Witaj na panelu admina'
        small 'Wybierz akcję na górze strony aby zarządzać treścią'
        small link_to('Nowa konsultacja', new_admin_consultation_path)
      end
    end

     columns do
       column max_width: '400px', min_width: '400px' do
         panel 'Ostatnie konsultacje' do
           ul do
             Consultation.order(updated_at: :desc).take(5).map do |consultation|
               li link_to(consultation.title, admin_consultation_path(consultation))
             end
           end
         end
       end

       column max_width: '400px', min_width: '400px' do
         panel 'Ostatnie komentarze' do
           ul do
             ConsultationComment.order(updated_at: :desc).take(5).map do |consultation_comment|
               next if consultation_comment.consultation.blank? and consultation_comment.consultation_comment.blank?
               li link_to(consultation_comment.user.name + ': ' + consultation_comment.created_at.to_s, admin_consultation_comment_path(consultation_comment))
             end
           end
         end
       end

       column max_width: '400px', min_width: '400px' do
         panel 'Ostatnio aktywni użytkownicy' do
           ul do
             User.order(last_sign_in_at: :desc).take(5).map do |user|
               li link_to(user.name + ': ' + user.last_sign_in_at.to_s, admin_user_path(user))
             end
           end
         end
       end

     end
  end
end
