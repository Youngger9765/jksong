module IssuesHelper

  def personal_decision
    if !@profile_issue
      "你還沒投票喔"
    elsif @profile_issue.decision && @profile_issue.decision == "1"
      "贊成"
    elsif @profile_issue.decision && @profile_issue.decision== "-1"
      "反對"
    elsif @profile_issue.decision && @profile_issue.decision == "0"
      "不表態"
    end  
  end


end
