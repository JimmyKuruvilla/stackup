class WelcomeController < ApplicationController
  def index
    @user=User.new
  end

  def send_daily_emails
    User.all.each do |user|
    UserMailer.send_daily_email(user).deliver
    end
    redirect_to root_path, :notice => "Emails sent to all users"
end

  def about
  end

  def team
  end
  
  def destroy_all_users #and make admins
    User.destroy_all
    User.create(id: 1, email: "jimmy.kuruvilla@flatironschool.com", created_at: "2014-11-26 04:15:53", updated_at: "2014-11-26 04:16:22", uid: "7905473", name: "Jimmy Kuruvilla", admin: true)
    User.create(id: 4, email: "seemashariat@gmail.com", created_at: "2014-11-26 17:16:06", updated_at: "2014-11-26 17:16:06", uid: "2113081", name: "seema shariat", admin: true)
    User.create(id: 5, email: "doneallison@gmail.com", created_at: "2014-11-26 17:18:09", updated_at: "2014-11-26 17:18:09", uid: "3227364", name: "Don Allison", admin: true)
    redirect_to root_path, :notice => "All users destroyed, and admins recreated"
  end

end
