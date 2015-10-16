class Admin::VotesController < ApplicationController

  #後台登入
  before_action :authenticate_user! 

  #檢查權限
  before_action :check_admin

  layout "admin"

  def index
    @votes = Vote.all

    if params[:vote_id]
      @vote = Vote.find( params[:vote_id] )
    else
      @vote = Vote.new
    end
    
  end

  def edit
    @vote = Vote.find(params[:id])
  end

  def update
    Vote.find(params[:id]).update(vote_params)
    flash[:notice] = "Update Success!"
    redirect_to admin_votes_path   
  end

  private

  def vote_params
    params.require(:vote).permit(:new_content, :category_id)
  end




end
