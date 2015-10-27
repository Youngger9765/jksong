class Issue < ActiveRecord::Base
    validates_presence_of :name, :content

    belongs_to :category

    belongs_to :user

    has_many :issue_vote_ships
    has_many :votes, :through => :issue_vote_ships

    has_many :profile_issue_ships
    has_many :votting_profiles, :through => :profile_issue_ships, :source => :profile

    has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

    def vote_list
      self.votes.map{ |v| v.uid }
    end

    def vote_list=(str)
      arr = str.split(",")

      self.votes = arr.map do |v|
        vote = Vote.find_by_uid(v)
        vote
      end
    end


end
