class ProfilesController < ApplicationController

  before_action :set_profile

  def index
  end

  def show
  end

  def update
    if @profile.update(profile_params)
      flash[:notice] = "event was successfully updated"
      redirect_to profile_path(@profile)
    else
      render :back
    end
  end

  def profile_issues_result
    @issues = current_user.get_issues_report
  end

  def profile_legislators_ships
    county = params[:county]
    @similar_legislators = current_user.get_similar_legislators(10,county)
    @categories = Category.all

    @user_max_vote_number=0
    @categories.each do |c|
      @profile.category_score_max(c.english_name)
      if @profile.category_score_max(c.english_name) > @user_max_vote_number
        @user_max_vote_number = @profile.category_score_max(c.english_name)
      end
      
    end

  end

  def registed_data
    @profile = current_user.profile
  end

  private

  def profile_params
    params.require(:profile).permit(:location_id, :username, :bio, :occupation, :vote_number )
  end

  def set_profile
    @profile = current_user.profile
  end

end
