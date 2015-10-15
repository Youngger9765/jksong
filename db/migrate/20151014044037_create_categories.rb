class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|

      t.string :name

      t.timestamps null: false
    end
  end

  add_index :issues, :category_id
  add_index :votes, :category_id

end
