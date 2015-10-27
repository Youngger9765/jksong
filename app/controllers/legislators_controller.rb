class LegislatorsController < ApplicationController

  def index
    @legislators = Legislator.all  
  end

  def show
    @legislator = Legislator.find(params[:id])
    @legislator_score_table = @legislator.profile_legislator_ships

    @categories = Category.pluck(:english_name)
    @scores = @legislator.get_scores_by_categories
  end
  

end
