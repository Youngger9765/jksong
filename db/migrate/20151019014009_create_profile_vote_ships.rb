class CreateProfileVoteShips < ActiveRecord::Migration
  def change
    create_table :profile_vote_ships do |t|

      t.integer :profile_id
      t.integer :vote_id
      t.string :decision
      t.string :conflict, :default =>"false"
      t.string :like, :default =>"false"
      
      t.timestamps null: false
    end

    add_index :profile_vote_ships, :profile_id
    add_index :profile_vote_ships, :vote_id

  end
end
