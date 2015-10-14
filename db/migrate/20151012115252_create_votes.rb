class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :vote_seq
      t.string :name
      t.string :content
      t.string :result
      t.integer :category_id
      t.timestamps null: false
    end
  end
end
