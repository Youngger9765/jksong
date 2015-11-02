class AddMobilePushToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mobile_push, :string, :default => "是"
  end
end
