class CreateLegislatorVoteShips < ActiveRecord::Migration
  def change
    create_table :legislator_vote_ships do |t|

      t.integer :legislator_id
      t.integer :vote_id
      t.string :decision, default: 0
      t.string :conflict, :default =>"false"

      t.timestamps null: false
    end

    add_index :legislator_vote_ships, :legislator_id
    add_index :legislator_vote_ships, :vote_id

  end
end
