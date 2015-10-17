class CreateIssueVoteShips < ActiveRecord::Migration
  def change
    create_table :issue_vote_ships do |t|

      t.timestamps null: false
    end
  end
end
