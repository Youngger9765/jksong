class CreateProfileLegislatorShips < ActiveRecord::Migration
  def change
    create_table :profile_legislator_ships do |t|
      
      t.integer :profile_id
      t.integer :legislator_id
      t.integer :total
      t.integer :law
      t.integer :education
      t.integer :social
      t.integer :traffic
      t.integer :diplomacy
      t.integer :finance
      t.integer :economy
      t.integer :interior
      t.timestamps null: false
    end
  end
end
