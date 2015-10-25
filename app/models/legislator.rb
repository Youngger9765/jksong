class Legislator < ActiveRecord::Base

  has_many :legislator_vote_ships
  has_many :votes, :through => :legislator_vote_ships

  has_many :profile_legislator_ships
  has_many :profiles, :through => :profile_legislator_ships

  def total_score(legislator_scores)
    legislator_scores.to_a.sum(&:total)
  end 

  def law_score(legislator_scores)
    legislator_scores.to_a.sum(&:law)
  end 

  def diplomacy_score(legislator_scores)
    legislator_scores.to_a.sum(&:diplomacy)
  end 
  
  def interior_score(legislator_scores)
    legislator_scores.to_a.sum(&:interior)
  end 

  def finance_score(legislator_scores)
    legislator_scores.to_a.sum(&:finance)
  end 

  def economy_score(legislator_scores)
    legislator_scores.to_a.sum(&:economy)
  end 

  def traffic_score(legislator_scores)
    legislator_scores.to_a.sum(&:traffic)
  end 

  def education_score(legislator_scores)
    legislator_scores.to_a.sum(&:education)
  end 

  def social_score(legislator_scores)
    legislator_scores.to_a.sum(&:social)
  end 


  

end
