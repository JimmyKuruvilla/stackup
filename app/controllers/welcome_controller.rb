class WelcomeController < ApplicationController
  def index
    @user=User.new
  end

  def send_daily_emails
		User.all.each do |user|
	    UserMailer.send_daily_email(user).deliver
	  end
	  redirect_to root_path
  end
  
end
