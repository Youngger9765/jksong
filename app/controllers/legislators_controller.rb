class LegislatorsController < ApplicationController

  def index
    @categories_all = Category.all
    @legislators = Legislator.all
    @categories = Category.pluck(:english_name)
    
  end

  def show
    @legislator = Legislator.find(params[:id])
    @legislator_score_table = @legislator.profile_legislator_ships

    @categories = Category.pluck(:english_name)
    @scores = @legislator.get_scores_by_categories

    @total_people_votes = Profile.sum("vote_number")
  end
  

end
