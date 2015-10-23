class CreateProfileLegislatorShips < ActiveRecord::Migration
  def change
    create_table :profile_legislator_ships do |t|
      
      t.integer :profile_id
      t.integer :legislator_id
      t.integer :total, default: 0
      t.integer :law, default: 0
      t.integer :education, default: 0
      t.integer :social, default: 0
      t.integer :traffic, default: 0
      t.integer :diplomacy, default: 0
      t.integer :finance, default: 0
      t.integer :economy, default: 0
      t.integer :interior, default: 0
      t.timestamps null: false
    end
  end
end
