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
      first_all_scores = nil
      second_all_scores = nil
      third_all_scores =nil
      first_max = nil
      second_max = nil
      third_max = nil

      legislators.each do |le|        
        get_score = all_scores[le][category[:english_name]].to_i

        if get_score > first_score
          first = le
          first_score = get_score
          first_all_scores = all_scores[le]
          first_max = first_all_scores.sort{|a,b|b[1]<=>a[1]}[1][1]
        elsif get_score > second_score
          second = le
          second_score = get_score
          second_all_scores = all_scores[le]
          second_max = second_all_scores.sort{|a,b|b[1]<=>a[1]}[1][1]
        elsif get_score > third_score
          third = le
          third_score = get_score
          third_all_scores = all_scores[le]
          third_max = third_all_scores.sort{|a,b|b[1]<=>a[1]}[1][1]
          
        end  
      end
      
      result[category[:english_name]] = {rank: [[first,first_all_scores,first_max],
                                                [second,second_all_scores,second_max],
                                                [third,third_all_scores,third_max]],
                                         name: category[:name]} 

      
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
