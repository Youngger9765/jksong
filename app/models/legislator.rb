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

  def self.get_higher_legislators_in_category(category)
    @legislators = Legislator.all
    
    get_score=0
    first_score=0
    second_score=0
    third_score=0

    first = nil
    second = nil
    third = nil

    @legislators.each do |le|
      get_score = le.get_scores_by_categories[category]
      puts get_score
      if get_score > first_score
        first = le
        first_score = get_score
      elsif get_score > second_score
        second = le
        second_score = get_score
      elsif get_score > third_score
        third = le
        third_score = get_score
      end  
    end
    puts 'checkeeee'
    puts [first,second,third]

    @legislators_list = [first,second,third]

  end

end
