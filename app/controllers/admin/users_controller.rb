class Admin::UsersController < ApplicationController

  #後台登入
  before_action :authenticate_user! 

  #檢查權限
  before_action :check_admin

  layout "admin"

  def index
    @profiles = Profile.all
    
  end

  def edit
    @profile = User.profile.find(params[:id])
  end

  def update
    User.profile.find(params[:id]).update(user_params)
    flash[:notice] = "Update Success!"
    redirect_to admin_users_path   
  end

  private

  def user_params
    params.require(:profile).permit(:role)
  end




end
