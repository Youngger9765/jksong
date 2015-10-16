class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :url
      t.string :uid
      t.string :original_content
      t.string :new_content
      t.string :conflict
      t.string :result
      t.integer :category_id
      t.string :user_id
      t.timestamps null: false
    end
  end
end
