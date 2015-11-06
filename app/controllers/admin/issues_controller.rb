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

  def show
    @issue = Issue.find(params[:id])
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

    if params[:issue][:vote_list]
      vote_list = params[:issue][:vote_list]
      vote_list.shift(1)

      vote_list.each do|v|
        vote_id = v.to_i
        IssueVoteShip.create( :issue_id => params[:id], :vote_id => vote_id)
      end
    end

    if params[:destroy_logo] == "1"

      @issue.logo = nil
    end

    flash[:notice] = "Update Success!"
    redirect_to admin_issue_path(params[:id])  
  end

  def destroy
    if params[:vote]
      issue_vote = IssueVoteShip.where(:issue_id => params[:id]).find_by_vote_id(params[:vote])
      issue_vote.destroy
      issue_vote.save
    end

    if params[:delete] == "issue"
      issue = Issue.find(params[:id])
      issue.delete
      issue.save!
    end

    respond_to do |format|
      format.html { redirect_to :back }
      format.js # destroy.js.erb
    end
  end

  def clear_all
    @profile = Profile.find(params[:profile_id])

    @profile.profile_legislator_ships.delete_all
    @profile.profile_issue_ships.delete_all

    @profile.vote_number = 0
    @profile.issue_number = 0
    @profile.save!

    redirect_to :back
  end

  protected

  def issue_params
    params.require(:issue).permit(:name, :category_id, :content, :vote_list, :logo)
  end

end
