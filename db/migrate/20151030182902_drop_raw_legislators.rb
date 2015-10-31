class DropRawLegislators < ActiveRecord::Migration
  def change
    drop_table :raw_legislators
    drop_table :legislators
  end
end
