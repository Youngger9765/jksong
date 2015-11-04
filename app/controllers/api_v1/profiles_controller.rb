class ApiV1::ProfilesController < ApiController

  before_action :authenticate_user_from_token!

  def update
    @profile = current_user.profile
    if authenticate_user_from_token!
      if profile_params
        @profile.update(profile_params)
        render :json => { :message => "auth_token OK",
                          :update => "update OK"}
      else
        render :json => { :message => "update fail"}
      end
    else                        
      render :json => { :message => "auth_token fail"}
    end

  end


  def profile_issues_result

    if authenticate_user_from_token!
      @profile = User.find_by_authentication_token( params[:auth_token] ).profile
      @issues = current_user.get_issues_report
    
    else
      render :json => { :message => "auth_token fail"}
    end
  end

  def profile_legislators_ships
    county = params[:county]
    legislator_number = params[:total_number]
    if authenticate_user_from_token!
      @profile = User.find_by_authentication_token( params[:auth_token] ).profile
      @similar_legislators = current_user.get_similar_legislators(legislator_number,county)
      @categories = Category.all

      @user_max_vote_number=0
      @categories.each do |c|
        @profile.category_score_max(c.english_name)
        if @profile.category_score_max(c.english_name) > @user_max_vote_number
          @user_max_vote_number = @profile.category_score_max(c.english_name)
        end
        
      end
  
    else
      render :json => { :message => "auth_token fail"}
    end
  end

  def registed_data
    if authenticate_user_from_token!
      @user = current_user
      @profile = current_user.profile
    else
      render :json => { :message => "auth_token fail"}
    end 
  end


  private

  def profile_params
    params.require(:profile).permit(:location_id, :username, :bio, :occupation)
  end



end
