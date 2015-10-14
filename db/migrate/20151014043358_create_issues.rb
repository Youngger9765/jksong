class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.name
      t.type
      t.content
      t.timestamps null: false
    end
  end
end
