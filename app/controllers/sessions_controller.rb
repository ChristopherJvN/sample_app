class SessionsController < ApplicationController
  def new
  end

  def create
    email_address = params[:session][:email_address]
    @user = User.find_by_email_address(email_address)
    if @user.nil?
      flash.now[:danger] = 'user name or password is incorrect'
      render 'new'
    else
      log_in @user
      redirect_to @user
    end
  end
  def destroy
    log_out
    render 'new'
  end
end
