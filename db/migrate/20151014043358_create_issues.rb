class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :name
      t.integer  :categoty_id
      t.string  :content
      t.timestamps null: false
    end
  end
end
