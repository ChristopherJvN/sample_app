class SessionsController < ApplicationController
  def new
  end

  def create
      @user = User.find_by(email_address: params[:session][:email_address].downcase)
    if @user && @user.authenticate(params[:session][:password])
        log_in @user
        redirect_to @user
      else
        flash.now[:danger] = 'user name or password is incorrect'
        render 'new'
    end
  end

  def destroy
    log_out
    render 'new'
  end
end
