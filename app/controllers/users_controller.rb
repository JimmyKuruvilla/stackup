class UsersController < ApplicationController

  def create
    @user = User.create(user_params)
    if User.find_by(email: @user.email)
      flash[:notice] = "You were successfully created."
      redirect_to @user
    else
      flash[:notice] = @user.errors.messages[:email][0]
      redirect_to root_path
    end
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