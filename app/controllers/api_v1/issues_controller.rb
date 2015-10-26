class ApiV1::IssuesController < ApiController

  def index
    @issues = Issue.all
  end

  def show
    @issue = Issue.find(params[:id])
    @profile = current_user.profile
    @profile_issue = ProfileIssueShip.where(:profile_id => current_user.profile.id).find_by_issue_id(@issue)
  end

  def create
    @issue = Issue.new( :name => params[:name])

    if @issue.save
      render :json => { :message => "OK", :id => @issue.id }
    else
      render :json => { :message => "Validate failed" }, :status => 400
    end
  end




end
