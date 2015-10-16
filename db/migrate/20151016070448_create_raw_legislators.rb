class CreateRawLegislators < ActiveRecord::Migration
  def change
    create_table :raw_legislators do |t|
      t.string  :url
      t.integer  :le_id
      t.string  :legislator
      t.integer :ad
      t.string  :name
      t.string  :gender
      t.string  :party
      t.string  :in_office
      t.text  :education
      t.text  :experience
      t.string  :image
      t.timestamps null: false
    end
  end
end
