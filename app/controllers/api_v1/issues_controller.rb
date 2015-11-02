class ApiV1::IssuesController < ApiController

before_action :authenticate_user_from_token!, only:[:vote]

  def index
    @issues = Issue.all
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

      render :json => { :message => "auth_token OK, update OK",
                        :issue_id => @issue.id,
                        :decision => @my_decision
                          }, :status => 200   
      else
      render :json => { :message => "auth_token fail",
                        

                          } 
    end
  end

end
