class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|

      t.string :name 
      t.timestamps null: false
    end

    add_column :issues, :category_id, :integer
    add_index :issues, :category_id

    add_column :votes, :category_id, :integer
    add_index :votes, :category_id

  end
end
