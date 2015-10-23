module LegislatorsHelper

  def legislator_vote_decision(legislator_id, vote_id)
    LegislatorVoteShip.where("legislator_id = ? AND vote_id = ?" , legislator_id,vote_id ).first.decision
  end

  def legislator_total_score(le_id)
    ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le_id).total
  end

end
