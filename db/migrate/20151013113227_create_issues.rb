class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.integer :issue_id
      t.string :name
      t.string :type
      t.string :content
      t.string :comment
      t.timestamps null: false
    end
  end
end
