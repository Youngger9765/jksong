class ProfileLegislatorShip < ActiveRecord::Base

  belongs_to :profile
  belongs_to :legislator

end
