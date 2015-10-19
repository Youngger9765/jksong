class LegislatorVoteShip < ActiveRecord::Base

  belongs_to :legislator
  belongs_to :vote

end
