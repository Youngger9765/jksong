class ChangeColumnContentToIssues < ActiveRecord::Migration
  def change
    change_column :issues, :content, :text, :limit => 65535
  end
end
