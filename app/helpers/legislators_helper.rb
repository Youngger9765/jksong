module LegislatorsHelper

  def legislator_vote_decision(legislator_id, vote_id)
    LegislatorVoteShip.where("legislator_id = ? AND vote_id = ?" , legislator_id,vote_id ).first.decision
  end

end
