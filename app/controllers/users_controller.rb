class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admin_only, except: [:show, :my_collection]

  def index
    @users = User.all
  end

  def my_collection
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    unless current_user.admin?
      unless @user == current_user
        redirect_to :back, :alert => "Access denied."
      end
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(secure_params)
      redirect_to :back, :notice => "User updated."
    else
      redirect_to :back, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def admin_only
    unless current_user.admin?
      redirect_to :back, :alert => "Access denied."
    end
  end

  def secure_params
    if @user == current_user
      params.require(:user).permit(:email)
    elsif current_user.admin?
      params.require(:user).permit(:role)
    end
  end

end
