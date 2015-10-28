class ApiV1::LegislatorsController < ApiController

  def index
    @legislators = Legislator.all
  end



end
