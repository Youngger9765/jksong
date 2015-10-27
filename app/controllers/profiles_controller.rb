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
      render "edit"
    end
  end

  def profile_issues_result
    @issues = current_user.get_issues_report
  end

  def profile_legislators_ships
    @similar_legislators = current_user.get_similar_legislators
  end

  private

  def profile_params
    params.require(:profile).permit(:location_id, :username, :bio, :occupation, :vote_number )
  end

  def set_profile
    @profile = current_user.profile
  end

end
