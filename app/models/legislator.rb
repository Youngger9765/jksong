class Legislator < ActiveRecord::Base

  has_many :legislator_vote_ships
  has_many :votes, :through => :legislator_vote_ships

  has_many :profile_legislator_ships
  has_many :profiles, :through => :profile_legislator_ships

  # def score(legislator_scores, category = 'total')
  #   legislator_scores.to_a.sum(&category.to_sym)
  # end

  categories = Category.pluck(:english_name) << 'total'
  categories.each do |category|
    define_method("#{category}_score") do |legislator_scores|
      legislator_scores.to_a.sum(&category.to_sym)
    end
  end

  # def total_score(legislator_scores)
  #   legislator_scores.to_a.sum(&:total)
  # end 

  # def law_score(legislator_scores)
  #   legislator_scores.to_a.sum(&:law)
  # end 

  # def diplomacy_score(legislator_scores)
  #   legislator_scores.to_a.sum(&:diplomacy)
  # end 
  
  # def interior_score(legislator_scores)
  #   legislator_scores.to_a.sum(&:interior)
  # end 

  # def finance_score(legislator_scores)
  #   legislator_scores.to_a.sum(&:finance)
  # end 

  # def economy_score(legislator_scores)
  #   legislator_scores.to_a.sum(&:economy)
  # end 

  # def traffic_score(legislator_scores)
  #   legislator_scores.to_a.sum(&:traffic)
  # end 

  # def education_score(legislator_scores)
  #   legislator_scores.to_a.sum(&:education)
  # end 

  # def social_score(legislator_scores)
  #   legislator_scores.to_a.sum(&:social)
  # end 


  

end
