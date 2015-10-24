class AddEnglishNameToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :english_name, :string
  end
end
