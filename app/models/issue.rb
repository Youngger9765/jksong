class Issue < ActiveRecord::Base
    validates_presence_of :name, :content

    belongs_to :category

    belongs_to :user

    has_many :votes


end
