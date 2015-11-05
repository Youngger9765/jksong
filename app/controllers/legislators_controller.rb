class LegislatorsController < ApplicationController

  def index
    @higher_legislators_by_categories = Legislator.get_higher_legislators
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
