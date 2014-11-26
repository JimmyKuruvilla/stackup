class UsersController < ApplicationController

  def create
  end

  def show
   @user = current_user
   @questions=Question.all
  end

  def index
  end

  def update
    @user=User.find(params[:id])
    @user.update(email: params[:user][:email])
    if User.find(params[:id]).email==params[:user][:email]
      message="Updated email to #{params[:user][:email]}"
    else
      message="Please enter a valid email address"
    end
    redirect_to @user, notice: message
  end


 private

  def user_params
    params.require(:user).permit(:email)
  end
end