class IssuesController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @issues = Issue.all
    if current_user
      @profile = current_user.profile
    else
      
    end
  end

  def show
    @issue = Issue.find(params[:id])
   
    if current_user      
      @my_decision = current_user.get_issue_decision(@issue)      
      @similar_legislators = current_user.get_similar_legislators
      @profile = current_user.profile
    end
  end

  def vote
    @issue = Issue.find(params[:id])    
    @profile = current_user.profile

    my_decision = if params[:votting] == "yes" 
       "1"
      elsif params[:votting] == "no"
        "-1"
      elsif params[:votting] == "pass"
        "0"
      end

    @ship = @profile.profile_issue_ships.where( :issue => @issue ).first_or_initialize
    @ship.decision = my_decision
    @ship.save!

    @profile.update_votes_count!
    @profile.rebuild_profile_legislator_ships!

    respond_to do |format|
      format.html { redirect_to :back }
      format.js 
    end    
  end

  def clear_vote
    @issue = Issue.find(params[:id])
    @profile = current_user.profile
    
    profile_issue = @profile.profile_issue_ships.find_by_issue_id(params[:id])
    profile_issue.destroy
    profile_issue.save!

    @profile.update_votes_count!
    @profile.rebuild_profile_legislator_ships!

    respond_to do |format|
      format.html { redirect_to :back }
      format.js 
    end 

  end

  def clear_all
    @issue = Issue.find(params[:id])
    @profile = current_user.profile

    ProfileLegislatorShip.delete_all
    ProfileIssueShip.delete_all

    @profile.vote_number = 0
    @profile.issue_number = 0
    @profile.save!

    redirect_to issue_path(params[:id])
  end


  private

  def issue_params
    params.require(:issue).permit()
  end



end
