class Category < ActiveRecord::Base

  has_many :issues

  has_many :votes

  def self.get_chinese_name(c)
    Category.find_by_english_name(c).name
  end

end
