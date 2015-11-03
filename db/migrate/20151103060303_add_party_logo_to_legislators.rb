class AddPartyLogoToLegislators < ActiveRecord::Migration
  def change
    add_column :legislators, :party_logo, :string
  end
end
