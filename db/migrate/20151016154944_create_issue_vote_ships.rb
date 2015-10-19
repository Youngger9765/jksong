class CreateIssueVoteShips < ActiveRecord::Migration
  def change
    create_table :issue_vote_ships do |t|

      t.integer :issue_id
      t.integer :vote_id

      t.timestamps null: false
    end
  end
end
