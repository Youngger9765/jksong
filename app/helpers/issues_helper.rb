module IssuesHelper

  def display_personal_decision(decision)
    if decision.nil?
      "你還沒投票喔"
    elsif decision == "1"
      "贊成"
    elsif decision == "-1"
      "反對"
    elsif decision == "0"
      "不表態"
    end
  end

 




end
