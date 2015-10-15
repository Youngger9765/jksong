class Category < ActiveRecord::Base

  has_many :issues

  has_many :votes

end
