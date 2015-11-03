class ApiV1::IssuesController < ApiController

before_action :authenticate_user_from_token!, only:[:vote]

  def index
    if authenticate_user_from_token!
      @profile = current_user.profile
      
      @issues = Issue.all
      issue_ids = Issue.includes(:profile_issue_ships).where(:profile_issue_ships => {:profile_id => @profile.id}).pluck(:id)     
      @issues = @issues.select{ |x| !issue_ids.include?(x.id) }

    else 
      @issues = Issue.all
    end
      

  end

  def show
    @issue = Issue.find(params[:issue_id])
    @profile = current_user.profile
    @profile_issue = ProfileIssueShip.where(:profile_id => current_user.profile.id).find_by_issue_id(@issue)
  end

  def vote

    if authenticate_user_from_token!
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
      
      @similar_legislators = current_user.get_similar_legislators(1)
      @my_decision = current_user.get_issue_decision(@issue) 

      @issues = current_user.get_issues_report
      @issues.each do |i|
        if i[:issue].id.to_s ==params[:id]
          @total_votting = i
        end
      end

      render :json => { :message => "auth_token OK, update OK",
                        :profile_id => @profile.id,
                        :issue_id => @issue.id,
                        :decision => @my_decision,
                        :total_yes => @total_votting[:total_yes],
                        :total_no => @total_votting[:total_no],
                        :total_pass => @total_votting[:total_pass]
                          }, :status => 200   
    else
      render :json => { :message => "auth_token fail"} 
    end
  end

  def clear_vote
    if authenticate_user_from_token!
      @issue = Issue.find(params[:id])
      @profile = current_user.profile
      
      profile_issue = @profile.profile_issue_ships.find_by_issue_id(params[:id])
      if profile_issue
        profile_issue.destroy
        profile_issue.save!
      end

      @profile.update_votes_count!
      @profile.rebuild_profile_legislator_ships!

      @similar_legislators = current_user.get_similar_legislators(1)
      @my_decision = current_user.get_issue_decision(@issue) 

      render :json => { :message => "auth_token OK, delete vote decision OK",
                        :profile_id => @profile.id,
                        :issue_id => @issue.id,
                        :decision => @my_decision
                          }, :status => 200  
    else
      render :json => { :message => "clear_vote auth_token fail"} 
    end



  end

  def clear_all
    if authenticate_user_from_token!
      @profile = current_user.profile

      ProfileLegislatorShip.delete_all
      ProfileIssueShip.delete_all

      @profile.vote_number = 0
      @profile.issue_number = 0
      @profile.save!
      render :json => { :message => "auth_token OK, delete ALL vote decision!",
                        :profile_id => @profile.id,
                        :profile_vote_number => @profile.vote_number,
                          }, :status => 200 
    else
      render :json => { :message => "clear_all auth_token fail"} 
    end

  end

end
