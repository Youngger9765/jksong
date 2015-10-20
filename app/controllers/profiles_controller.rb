class ProfilesController < ApplicationController

  def index
    
  end

  def show
    @profile = Profile.find( params[:id] )
    
  end

  def update
    @profile = Profile.find( params[:id] )
    if @profile.update(profile_params)
      flash[:notice] = "event was successfully updated"
      redirect_to profile_path(@profile)
    else
      render "edit"
    end
  end

  def profile_issue_result
    @profile = current_user.profile
    @issues = @profile.votting_issues
    @profile_issue_ships = ProfileIssueShip.where(:profile_id => @profile.id)
  end
  



  private

  def profile_params
    params.require(:profile).permit(:location_id, :username, :bio, :occupation )
  end

end
