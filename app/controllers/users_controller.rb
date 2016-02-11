class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'User updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  # # DELETE /users/1
  # # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy
  #   User.find(params[:id]).destroy
   flash[:success] = "User deleted"
   redirect_to users_url
   end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params) # Not the final implementation!
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
end
