class ApiV1::LegislatorsController < ApiController

  def index
    category = params[:category]
    @higher_legislators_by_categories = Legislator.get_higher_legislators
    @higher_legislators_by_category = nil

    @higher_legislators_by_categories.each do |hl|
      if hl[0] == category
        @higher_legislators_by_category = hl
      end
    end

    @legislators = Legislator.all
    @categories = Category.pluck(:english_name) 
  end


end
