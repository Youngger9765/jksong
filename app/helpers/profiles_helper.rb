module ProfilesHelper

  def profile_issue_decision(profile_id, issue_id)
    ProfileIssueShip.where("profile_id = ? AND issue_id = ?" , profile_id,issue_id ).first.decision
  end

end
