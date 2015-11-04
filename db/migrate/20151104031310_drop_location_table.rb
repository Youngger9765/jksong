class DropLocationTable < ActiveRecord::Migration
  def change
    drop_table :locations

    create_table :locations do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end
