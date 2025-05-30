class CreateUserProfiles < ActiveRecord::Migration[7.2]
  def change
    create_table :user_profiles do |t|
      t.string :name
      t.text :bio
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
