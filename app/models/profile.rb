class Profile < ActiveRecord::Base

    belongs_to :user

    belongs_to :location

   # has_many :profile_vote_ships
    #has_many :votting_votes, :through => :profile_vote_ships, :source => :vote

    has_many :profile_issue_ships
    has_many :votting_issues, :through => :profile_issue_ships, :source => :issue

    has_many :profile_legislator_ships
    has_many :legislators, :through => :profile_legislator_ships

    def admin?
      self.role == "admin"
    end

    def vote_issue?(issue)
      self.votting_issues.include?(issue)
    end
    
    def rebuild_profile_legislator_ships!  

      legislator_ids = Legislator.pluck(:id)
      categories = Category.pluck(:english_name) << "total"

      # get scores
      scores = Hash[ legislator_ids.map {|i| [i, Hash[categories.map{ |c| [c,0] }]] } ]

      my_issue_votes = Hash[ self.profile_issue_ships.pluck(:issue_id, :decision) ]
      my_issue_ids = my_issue_votes.keys

      votes = IssueVoteShip.includes(:issue => :category).where( :issue_id => my_issue_ids )
      vote_ids = votes.map{ |v| v.vote_id }
      vote_category_mapping = Hash[ votes.map{ |v| [v.vote_id, v.issue.category.english_name] } ]

      my_vote_decision = Hash[ votes.map{ |v| [v.vote_id,  my_issue_votes[v.issue_id]] } ]

      related_legislator_votes = LegislatorVoteShip.where( :vote_id => vote_ids )
      related_legislator_votes.each do |v|
        if v.decision.to_s == my_vote_decision[v.vote_id].to_s
          scores[ v.legislator_id ][ vote_category_mapping[v.vote_id] ] += 1
          scores[ v.legislator_id ][ "total" ] += 1
        end
      end

      # create profile_legislator_ships
      ActiveRecord::Base.transaction do    
        profile_legislator_ships.delete_all
        legislator_ids.each do |legislator_id|
          ship = self.profile_legislator_ships.new( :legislator_id => legislator_id, :profile_id =>  self.id)
          categories.each do |c|
            ship.public_send("#{c}=", scores[legislator_id][c] )
          end
          ship.save!
        end
      end
      
      ProfileLegislatorShip.where(:profile_id => nil).destroy_all

    end

    def update_votes_count!
      issue_ids = self.profile_issue_ships.pluck(:issue_id)      
      self.issue_number = issue_ids.size
      self.vote_number =  IssueVoteShip.where( :issue_id => issue_ids ).count
      self.save!      
    end

end
