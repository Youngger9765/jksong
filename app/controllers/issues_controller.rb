class IssuesController < ApplicationController

  def index
    if params[:category_id]
      @issues = Issue.where(:category_id => params[:category_id])

    else
      @issues = Issue.all
    end

  end

  def show
    @issue = Issue.find(params[:id])
    @p = ProfileIssueShip.where(:profile_id => current_user.profile.id).find_by_issue_id(@issue)
    
  end

  def new
    @issue = Issue.new
  end

  def create
    @issue = Issue.new(issue_params)
    @issue.save
    flash[:notice] = "新增成功的訊息"
    redirect_to issues_path
  end

  def edit
    @issue = Issue.find(params[:id])
  end

  def update
    @issue = Issue.find(params[:id])
    
    if @issue.update(issue_params)
      flash[:notice] = "更新成功"
      redirect_to issue_path(@issue)
    else
      render "edit"
    end
  end

  def destroy
    @issue = Issue.find(params[:id])
    @issue.destroy
    flash[:alert] = "刪除成功"
    redirect_to :back
  end

  def user_votting

    @issue = Issue.find(params[:id])
    @p = ProfileIssueShip.where(:profile_id => current_user.profile.id).find_by_issue_id(@issue)

    if current_user && !current_user.profile.vote_issue?(@issue)
      ProfileIssueShip.create(:profile_id => current_user.profile.id, :issue_id => @issue.id, :decision => 0)

      if params[:votting] == "yes"
        @p.update(:decision => 1)
      elsif params[:votting] == "no"
        @p.update(:decision => -1)
      elsif params[:votting] == "clean"
        @p.update(:decision => 0)
      else

      end

      flash[:notice] = "vote_finish"
      redirect_to issue_path(params[:id])  

    elsif current_user && current_user.profile.vote_issue?(@issue)
      @p = ProfileIssueShip.where(:profile_id => current_user.profile.id).find_by_issue_id(@issue)
      if params[:votting] == "yes"
        @p.update(:decision => 1)
        flash[:alert] = "更新為贊成"
      elsif params[:votting] == "no"
        @p.update(:decision => -1)
        flash[:alert] = "更新為反對"
      elsif params[:votting] == "clean"
        @p.update(:decision => 0)
        flash[:alert] = "更新為不表態"
      else

      end
      
      redirect_to issue_path(params[:id]) 

    end   

  end


  private

  def issue_params
    params.require(:issue).permit(:content, :name, :category_id)
  end



end
