class CreateProfileIssueShips < ActiveRecord::Migration
  def change
    create_table :profile_issue_ships do |t|

      t.integer :profile_id
      t.integer :issue_id
      t.string :decision
      t.string :conflict, :default =>"false"
      t.string :like, :default =>"false"
      
      t.timestamps null: false
    end

    add_index :profile_issue_ships, :profile_id
    add_index :profile_issue_ships, :issue_id
  end
end
