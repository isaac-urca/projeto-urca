class AddDetailsToUserProfile < ActiveRecord::Migration[7.2]
  def change
    add_column :user_profiles, :lattes_link, :string
    add_column :user_profiles, :role, :integer, default: 0
  end
end
