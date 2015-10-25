class Issue < ActiveRecord::Base
    validates_presence_of :name, :content

    belongs_to :category

    belongs_to :user

    has_many :issue_vote_ships
    has_many :votes, :through => :issue_vote_ships

    has_many :profile_issue_ships
    has_many :votting_profiles, :through => :profile_issue_ships, :source => :profile

    def vote_list
      self.votes.map{ |v| v.uid }
    end

    def vote_list=(str)
      arr = str.split(",")

      self.votes = arr.map do |v|
        vote = Vote.find_by_uid(v)
        vote
      end
    end


    def legislator_category_score_subtraction(user_id,le,category_name)
        
        score = ProfileLegislatorShip.where(:profile_id => user_id).find_by_legislator_id(le.id)[category_name]
        
        score -= 1
        ProfileLegislatorShip.where(:profile_id => user_id).find_by_legislator_id(le.id).update(category_name => score)
        
        total_score = ProfileLegislatorShip.where(:profile_id => user_id).find_by_legislator_id(le.id)[:total]
        
        total_score -= 1
        ProfileLegislatorShip.where(:profile_id => user_id).find_by_legislator_id(le.id).update(:total => total_score)
        
    end


    def legislator_category_score_plus(user_id,le,category_name)
        score = ProfileLegislatorShip.where(:profile_id => user_id).find_by_legislator_id(le.id)[category_name]
        
        score += 1
        ProfileLegislatorShip.where(:profile_id => user_id).find_by_legislator_id(le.id).update(category_name => score)
        
        total_score = ProfileLegislatorShip.where(:profile_id => user_id).find_by_legislator_id(le.id)[:total]
        
        total_score += 1
        ProfileLegislatorShip.where(:profile_id => user_id).find_by_legislator_id(le.id).update(:total => total_score)

    end



end
