class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log in user and redirect to user's page
    else
      flash.now[:danger] = 'Invalid email & password combination. Try again.'
      render 'new'
    end
  end

  def destroy
  end
end
