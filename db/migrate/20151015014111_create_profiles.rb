class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string  :username
      t.integer :user_id
      t.integer :location_id
      t.string :status
      t.timestamps null: false
    end

    add_index :profiles, :status
    add_index :profiles, :user_id
    add_index :profiles, :location_id

  end
  
end
