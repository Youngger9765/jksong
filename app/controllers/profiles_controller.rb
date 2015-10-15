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

  private

  def profile_params
    params.require(:profile).permit(:location_id, :username )
  end

end
