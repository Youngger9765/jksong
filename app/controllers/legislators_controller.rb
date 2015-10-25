class LegislatorsController < ApplicationController

  def index
    @profile = Profile.find(params[:profile_id])
    @legislators = Legislator.all  
  end

  def show
    @profile = Profile.find(params[:profile_id])
    @legislator = Legislator.find(params[:id])
    @votes = Legislator.find(params[:id]).votes
    @legislator_score_table = ProfileLegislatorShip.where(:legislator_id => params[:id])

  end
  

end
