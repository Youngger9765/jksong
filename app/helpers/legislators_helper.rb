module LegislatorsHelper

  def legislator_total_score(le)
    le.profile_legislator_ships.first.total
  end

end
