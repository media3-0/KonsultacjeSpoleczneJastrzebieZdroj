class UserMailer < ActionMailer::Base
  default from: 'noreply@konsultacje.jastrzebie.pl'

  def report_email(comment)
    @id = comment.id
    @user_url  = admin_user_url(comment.user.id)
    @user_name = comment.user.name
    @url = admin_consultation_comment_url(comment)
    mail(to: 'konsultacje.jastrzebie@gmail.com', subject: "Zgłoszenie komentarza id: #{comment.id}")
  end

  def send_reminder
  	users = User.where(sign_in_count: 0)
  	users.each do |user|
  		mail(to: user.email, subject: 'Zapraszamy na platformę konsultacje.jastrzebie.pl')
  	end
  end
end
