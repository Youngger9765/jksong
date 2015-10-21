class Vote < ActiveRecord::Base
  validates_presence_of :original_content

  belongs_to :user

  belongs_to :category

  has_many :issue_vote_ships
  has_many :relative_issues, :through => :issue_vote_ships, :source => :issue

  has_many :legislator_vote_ships
  has_many :legislators, :through => :legislator_vote_ships

  has_many :profile_vote_ships
  has_many :votting_profiles, :through => :profile_vote_ships, :source => :profile

end
