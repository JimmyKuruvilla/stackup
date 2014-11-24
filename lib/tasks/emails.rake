namespace :emails do
  desc "refreshes Questions database and sends all Users an email"
  task send_daily_emails: :environment do
  	Question.delete_answered_questions
    Question.get_questions
    
    User.all.each do |user|
      UserMailer.send_daily_email(user).deliver
    end
    # UserMailer.daily_email(self).deliver
  end
end