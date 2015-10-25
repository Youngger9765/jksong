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
    @issues = @profile.votting_issues
    @profile_issue_ships = ProfileIssueShip.where(:profile_id => @profile.id)
  end

  def profile_legislators_ships
    @legislator = Legislator.all
    @issues = @profile.votting_issues
  end



  private

  def profile_params
    params.require(:profile).permit(:location_id, :username, :bio, :occupation, :vote_number )
  end

  def set_profile
    @profile = Profile.find(params[:id])
  end

end
