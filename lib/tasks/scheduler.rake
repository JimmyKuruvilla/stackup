namespace :emails do
  desc "refreshes Questions database and sends all Users an email"
  task send_daily_emails: :environment do
    Question.get_questions
    UserMailer.cron_worked.deliver
    # UserMailer.daily_email(self).deliver
  end
end