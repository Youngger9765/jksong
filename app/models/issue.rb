class Issue < ActiveRecord::Base
    validates_presence_of :name, :content

    belongs_to :category

    belongs_to :user

    has_many :issue_vote_ships
    has_many :votes, :through => :issue_vote_ships

    has_many :profile_issue_ships
    has_many :votting_profiles, :through => :profile_issue_ships, :source => :profile


end
