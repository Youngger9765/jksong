class Vote < ActiveRecord::Base
  validates_presence_of :original_content

  belongs_to :user

  belongs_to :category

  has_many :issue_vote_ships
  has_many :votes, :through => :issue_vote_ships

end
