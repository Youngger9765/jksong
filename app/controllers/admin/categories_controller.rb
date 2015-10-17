class Admin::CategoriesController < ApplicationController

  #後台登入
  before_action :authenticate_user! 

  #檢查權限
  before_action :check_admin

  layout "admin"

  def index
    @categories = Category.all

    if params[:categorie_id]
      @category = Category.find( params[:categorie_id] )
    else
      @category = Category.new
    end
    
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    category.find(params[:id]).update(category_params)
    flash[:notice] = "Update Success!"
    redirect_to admin_category_path   
  end

  private

  def category_params
    params.require(:category).permit()
  end




end
