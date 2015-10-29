class User < ActiveRecord::Base

  validates_presence_of :email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_one :profile

  has_many :issues
  has_many :votes

  before_create :generate_authentication_token

  def get_issue_decision(issue)
    ship = ProfileIssueShip.where(:profile_id => self.profile.id, :issue_id => issue.id).first
    ship.try(:decision)
  end

  def get_similar_legislators(n=10)
     les = Legislator.includes(:profile_legislator_ships).where(:profile_legislator_ships => {:profile_id => self.profile.id}).order("total DESC").limit(n)
     my_votes_count = self.profile.vote_number
     
     les.map do |le|
       { 
         :legislator => le,
         :score => ((le.profile_legislator_ships.first.total.to_f / my_votes_count)*100).round(2)
       }
     end
  end

  def get_issues_report
    my_ships = self.profile.profile_issue_ships.includes(:issue => :category)
    issues_ids = my_ships.map{ |s| s.issue_id }
    all_ships = ProfileIssueShip.where( :issue_id => issues_ids )

    my_ships.map do |s|
      {
        :issue => s.issue,
        :category => s.issue.category.name,
        :decision => s.decision,
        :total_yes => all_ships.select{ |a| a.issue_id == s.issue_id && a.decision == "1" }.size,
        :total_no => all_ships.select{ |a| a.issue_id == s.issue_id && a.decision == "-1" }.size,
      }
    end
  end

  def username
    self.profile.username
  end

  def admin?
    self.profile.role == "admin"
  end

  def generate_authentication_token
    self.authentication_token = Devise.friendly_token
  end

  def self.from_omniauth(auth)
    # Case 1: Find existing user by facebook uid
    user = User.find_by_fb_uid( auth.uid )
    if user
      user.fb_token = auth.credentials.token
      user.fb_raw_data = auth
      user.save!
      return user
    end

    # Case 2: Find existing user by email
    existing_user = User.find_by_email( auth.info.email )
    if existing_user
      existing_user.fb_uid = auth.uid
      existing_user.fb_token = auth.credentials.token
      existing_user.fb_raw_data = auth
      existing_user.save!
      return existing_user
    end

    # Case 3: Create new password
    user = User.new
    user.fb_uid = auth.uid
    user.fb_token = auth.credentials.token
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.fb_raw_data = auth
    user.save!
    profile = user.create_profile
    profile.username = auth.info.name
    profile.save!
    return user
  end

end
