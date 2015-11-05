class ApiV1::LegislatorsController < ApiController

  def index
    @higher_legislators_by_categories = Legislator.get_higher_legislators
    @legislators = Legislator.all
    @categories = Category.pluck(:english_name) 
  end


end
