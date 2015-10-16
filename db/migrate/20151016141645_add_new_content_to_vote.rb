class AddNewContentToVote < ActiveRecord::Migration
  def change
    change_column :votes, :original_content, :text, :limit => 6553555
    change_column :votes, :new_content, :text, :limit => 6553555
  end
end
