class Profile < ActiveRecord::Base

    belongs_to :user

    belongs_to :location

    has_many :profile_vote_ships
    has_many :votting_votes, :through => :profile_vote_ships, :source => :vote

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

    def profile_total_vote_issue_number_calculation(user,number)
      user.profile[:vote_number] += number
      user.profile[:issue_number]+= 1
      user.profile.save
    end
    

    




end
