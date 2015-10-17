class IssueVoteShip < ActiveRecord::Base

  belongs_to :issue
  belongs_to :vote

end
