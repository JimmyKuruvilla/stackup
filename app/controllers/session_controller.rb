class SessionController < ApplicationController

  def create     
    auth = request.env["omniauth.auth"]     
    if User.find_by(uid: auth["uid"])==nil
      message="You can expect your first StackUp email to appear within 24 hours"
    end
    @user = User.find_by(uid: auth["uid"]) || User.create_with_omniauth(auth)     
    session[:user_id] = @user.id     

    redirect_to @user, :notice => message
  end

  def new
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  def failure
  end
end
