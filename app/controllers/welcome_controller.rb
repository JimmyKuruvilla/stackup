class WelcomeController < ApplicationController


  def index
    @user=current_user
  end

  def about
    @user=current_user
  end

  def team
    @user=current_user
  end
  
  def admin_actions
    message="Error Occured - see Admin Actions in Welcome Controller"
      if current_user && current_user.admin

        if params[:admin_actions]=="dauara"

          session[:user_id]=nil
          User.destroy_all
          User.create(id: 1, email: "jimmy.kuruvilla@flatironschool.com", created_at: "2014-11-26 04:15:53", updated_at: "2014-11-26 04:16:22", uid: "7905473", name: "Jimmy Kuruvilla", admin: true)
          User.create(id: 2, email: "seemashariat@gmail.com", created_at: "2014-11-26 17:16:06", updated_at: "2014-11-26 17:16:06", uid: "2113081", name: "Seema Shariat", admin: true)
          User.create(id: 3, email: "doneallison@gmail.com", created_at: "2014-11-26 17:18:09", updated_at: "2014-11-26 17:18:09", uid: "3227364", name: "Don Allison", admin: true)
          message="All users destroyed, and admins recreated"

        elsif params[:admin_actions]=="rde"

          User.all.each do |user|
          UserMailer.send_daily_email(user).deliver
          end
          message="Emails sent to all users"

      end

      else
        message="You must be an admin to perform that action"
      end

      redirect_to root_path, :notice => message
    end


  end
