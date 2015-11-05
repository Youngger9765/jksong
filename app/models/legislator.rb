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
  
  def get_scores_by_categories(catrgories=nil)
    if catrgories
      category_names = catrgories.map{ |c| c.english_name }
    else
      category_names = Category.pluck(:english_name) 
    end
    category_names << 'total'

    results = Hash.new(0)

    self.profile_legislator_ships.each do |s|
      category_names.each do |c|
        results[c] += s.public_send(c)
      end
    end    
    results
  end  

  def self.get_higher_legislators
    legislators = Legislator.includes(:profile_legislator_ships).all
    categories = Category.all
    result = {}

    all_scores = {}
    legislators.each do |le|
      all_scores[le] = le.get_scores_by_categories(categories)
    end

    cat = categories.map{|c| {english_name: c.english_name, name:c.name}}.unshift({english_name:"total",name:"總票數"})
    # categories.each do |category|
    cat.each do |category|
      get_score=0
      first_score=0
      second_score=0
      third_score=0

      first = nil
      second = nil
      third = nil

      legislators.each do |le|        
        get_score = all_scores[le][category[:english_name]].to_i

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
      result[category[:english_name]] = {rank: [first,second,third], name:category[:name]} 
      
    end
    
    result
    
  end

  def self.get_higher_legislators_in_category(category)
    legislators = Legislator.all
    
    get_score=0
    first_score=0
    second_score=0
    third_score=0

    first = nil
    second = nil
    third = nil

    legislators.each do |le|
      get_score = le.get_scores_by_categories[category]

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

    [first,second,third]

  end

end
