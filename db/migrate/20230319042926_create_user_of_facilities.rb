class CreateUserOfFacilities < ActiveRecord::Migration[7.0]
  def change
    create_table :user_of_facilities do |t|
      t.integer :user_id
      t.string :name
      t.string :organization
      t.string :group
      t.string :address
      t.string :tel
      t.string :email
      t.string :handicap_name
      t.integer :handicap_level

      t.timestamps
    end
  end
end
