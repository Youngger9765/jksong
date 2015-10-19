class ProfileIssueShip < ActiveRecord::Base

  belongs_to :profile
  belongs_to :issue

end
