class UsersController < ApplicationController

  def create
    @user = User.create(user_params)
    flash[:notice] = "You were successfully created."
    redirect_to @user
  end

  def show
   @user = User.find(params[:id])
  end

  def index
  end

 private

  def user_params
    params.require(:user).permit(:email)
  end
end
