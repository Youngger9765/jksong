class ProfileVoteShip < ActiveRecord::Base

  belongs_to :profile
  belongs_to :vote


end
