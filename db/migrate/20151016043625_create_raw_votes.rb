class CreateRawVotes < ActiveRecord::Migration
  def change
    create_table :raw_votes do |t|
      t.string :url
      t.string :uid
      t.string :sitting_id
      t.string :vote_seq
      t.text :content, :limit => 6553555
      t.string :conflict
      t.string :results
      t.string :result
      t.timestamps null: false
    end
  end
end
