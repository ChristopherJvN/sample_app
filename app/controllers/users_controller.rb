class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :admin_user,     only: :destroy
  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'User updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def edit
  end

  def destroy
    @user.destroy
    flash[:success] = 'User deleted'
    redirect_to users_url
   end

  def show
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Welcome to the Sample App!'
      redirect_to @user
    else
      render 'new'
    end
  end
  private def user_params
    params.require(:user).permit(:name, :email_address, :password,
                                 :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
   end
end
