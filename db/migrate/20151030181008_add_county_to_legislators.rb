class AddCountyToLegislators < ActiveRecord::Migration
  def change
    add_column :legislators, :county, :string
    add_column :raw_legislators, :county, :string

  end
end
