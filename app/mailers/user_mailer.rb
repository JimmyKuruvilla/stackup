class UserMailer < ActionMailer::Base
  default from: 'stackupemail@gmail.com'
    def daily_email(user)
      @user = user
      @question=Question.first
      mail(to: @user.email, subject: 'Your Daily Question from StackUp')
    end

    def cron_worked
      mail(to: "jimmyjk@gmail.com", subject: 'cron worked!')
    end

end