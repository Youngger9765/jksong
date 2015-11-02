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
  
  def get_scores_by_categories
    categories = Category.pluck(:english_name) << 'total'
    results = Hash.new(0)

    self.profile_legislator_ships.each do |s|
      categories.each do |c|
        results[c] += s.public_send(c)
      end
    end    

    results
  end  

  def get_higher_legislators_in_category(n=10, category)
     

  end

end
