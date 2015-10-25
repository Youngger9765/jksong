class AddVoteNumberToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :vote_number, :integer, :default => 0
    add_column :profiles, :issue_number, :integer, :default => 0
  end
end
