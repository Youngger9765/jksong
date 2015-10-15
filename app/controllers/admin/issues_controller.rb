class Admin::IssuesController < ApplicationController

  #後台登入
  before_action :authenticate_user! 

  #檢查權限
  before_action :check_admin

  layout "admin"

  def index
    @issues = Issue.all

    if params[:id]
      @issue = Issue.find( params[:id] )
    end
  end

  def update
    Issue.find(params[:id]).update(issue_params)
    flash[:notice] = "Update Success!"
    redirect_to admin_issues_path   
  end

  protected

  def issue_params
    params.require(:issue).permit(:name, :category_id, :content)
  end

end
