class Legislator < ActiveRecord::Base

  has_many :legislator_vote_ships
  has_many :votes, :through => :legislator_vote_ships

end
