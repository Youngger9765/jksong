class Vote < ActiveRecord::Base
  validates_presence_of :original_content


  belongs_to :user

  belongs_to :category

end
