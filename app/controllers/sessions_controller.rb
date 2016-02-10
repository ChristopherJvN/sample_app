class SessionsController < ApplicationController
  def new
  end

  def create
    email_address = params[:session][:email_address]
    @user = User.find_by_email_address(email_address)
    if @user.nil?
      render 'new'
    else
      redirect_to @user
    end
  end
end
