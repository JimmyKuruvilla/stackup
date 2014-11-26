class UserMailer < ActionMailer::Base
  default from: 'stackupemail@gmail.com'
    def send_daily_email(user)
      @user = user
      @question=Question.pick_question(user)
      @user.questions<<@question
      mail(to: @user.email, subject: 'Your Daily Question from StackUp')
    end

    def send_welcome_email(user)
      @user = user
      #pass question variables for html view
      mail(to: @user.email, subject: 'Welcome to StackUp!')
    end


end