class UsersController < ApplicationController

  def create
  end

  def show
   @user = current_user
   Question.pick_question(@user)
   @questions=Question.first(10)
  end

  def index
    @user = current_user
  end

  def update
    @user=User.find(params[:id])
    if params[:user][:email] ==""
      @user.destroy
      session[:user_id]=nil
      message="You have been unsubscribed from the list"
      redirect_to root_path, notice: message
    else    

      @user.update(email: params[:user][:email])
      if User.find(params[:id]).email==params[:user][:email]
        message="Updated email to #{params[:user][:email]}"
      else
        message="Please enter a valid email address"
      end
        redirect_to @user, notice: message
    end
    
  end


 private

  def user_params
    params.require(:user).permit(:email)
  end
end