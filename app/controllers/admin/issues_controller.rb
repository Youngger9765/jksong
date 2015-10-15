class Admin::IssuesController < ApplicationController

  #後台登入
  before_action :authenticate_user! 

  #檢查權限
  before_action :check_admin

  layout "admin"

  def index
    @issues = Issue.all

    if params[:issue_id]
      @issue = Issue.find( params[:issue_id] )
    else
      @issue = Issue.new
    end

  end

  def create
    @issue = Issue.new(issue_params)
    @issue.user = current_user

    if @issue.save
      flash[:notice] = "Create Success!"
      redirect_to admin_issues_path
    else
      flash[:alert] = "Create fail!"
      render admin_issues_path
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
