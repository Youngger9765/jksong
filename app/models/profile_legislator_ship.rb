class ProfileLegislatorShip < ActiveRecord::Base

  belongs_to :profile
  belongs_to :legislator

  def get_score(c)
    self["#{c}"]
  end

end
