class Profile < ActiveRecord::Base

    belongs_to :user

    belongs_to :location

    def admin?
      self.role == "admin"
    end

end
