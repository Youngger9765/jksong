class Issue < ActiveRecord::Base
    validates_presence_of :name, :content

    belongs_to :category
end
