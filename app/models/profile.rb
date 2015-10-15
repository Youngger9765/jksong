class Profile < ActiveRecord::Base

    belongs_to :user

    def admin?
      self.role == "admin"
    end

end
