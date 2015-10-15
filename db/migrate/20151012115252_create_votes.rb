class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :vote_seq
      t.string :original_content
      t.string :new_content
      t.string :result
      t.integer :category_id
      t.string :user_id
      t.timestamps null: false
    end
  end
end
