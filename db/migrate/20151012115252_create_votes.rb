class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer "vote_seq"
      t.string "content"
      t.string "result"s
      t.timestamps null: false
    end
  end
end
