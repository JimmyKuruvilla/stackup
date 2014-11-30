class UsersController < ApplicationController

  def index
    redirect_to "users#show" and return# does this work?
  end

  def show
    @questions=[]
    @user = current_user # currently no security on changing session cookies to view other user pages
      10.times do 
        @questions<<Question.pick_question(@user)
      end
    end

  def update
    @user=User.find(params[:id])
    if params[:user][:email] ==""
      @user.destroy
      session[:user_id]=nil
      session[:message]="You have been unsubscribed from the list"
      redirect_to root_path
    else    

      @user.update(email: params[:user][:email])
      if User.find(params[:id]).email==params[:user][:email]
        @message="Updated email to #{params[:user][:email]}"
      else
        @message="Please enter a valid email address"
      end
        #render js view
    end
    
  end


 private

  def user_params
    params.require(:user).permit(:email)
  end
end