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



  private

  def issue_params
    params.require(:issue).permit(:content, :name, :category_id)
  end


end
