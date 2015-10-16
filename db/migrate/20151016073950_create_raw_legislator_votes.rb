class CreateRawLegislatorVotes < ActiveRecord::Migration
  def change
    create_table :raw_legislator_votes do |t|
      t.string :url
      t.integer :decision
      t.string :conflict, :default =>"false"
      t.string  :legislator
      t.string  :vote
      t.timestamps null: false
    end
  end
end
