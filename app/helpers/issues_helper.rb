module IssuesHelper

  def personal_decision



    if @profile_issue.try(:decision) = "1"
      "贊成"
    elsif @profile_issue.try(:decision) = "-1"
      "反對"
    elsif @profile_issue.try(:decision) = "0"
      "不表態"
    end  
  end


end
