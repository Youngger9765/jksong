class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string  :username
      t.integer :user_id
      t.integer :location_id, :default => "未填寫"
      t.string :status, :default => "未填寫"
      t.string :role, :default => "normal"
      t.string :bio, :default => "未填寫"
      t.string :occupation, :default => "未填寫"
      t.timestamps null: false
    end

    add_index :profiles, :status
    add_index :profiles, :user_id
    add_index :profiles, :location_id

  end
  
end
