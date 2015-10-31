class ApiV1::ProfilesController < ApiController

  before_action :authenticate_user!
  before_action :authenticate_user_from_token!

  def profile_issues_result

    if authenticate_user_from_token!
      @profile = User.find_by_authentication_token( params[:auth_token] ).profile
      @issues = current_user.get_issues_report
    
    else
      render :json => { :message => "auth_token fail",
                        }, :status => 401
    end
  end

  def profile_legislators_ships
    legislator_number = params[:total_number]
    if authenticate_user_from_token!
      @profile = User.find_by_authentication_token( params[:auth_token] ).profile
      @similar_legislators = current_user.get_similar_legislators(legislator_number)
      @categories = Category.all

    else
      render :json => { :message => "auth_token fail",
                        }, :status => 401
    end
  end



end
