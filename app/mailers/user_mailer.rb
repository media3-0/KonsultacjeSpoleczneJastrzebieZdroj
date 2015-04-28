class UserMailer < ActionMailer::Base
  default from: 'konsultacje.jastrzebie@gmail.com'

  def report_email(comment)
    @id = comment.id
    @user_url  = admin_user_url(comment.user.id)
    @user_name = comment.user.name
    @url = admin_consultation_comment_url(comment)
    mail(to: 'konsultacje.jastrzebie@gmail.com', subject: "Zgłoszenie komentarza id: #{comment.id}")
  end
end
