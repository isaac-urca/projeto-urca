class CreateMemberships < ActiveRecord::Migration[7.2]
  def change
    create_table :memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :research_group, null: false, foreign_key: true
      t.integer :role, default: 0 # 0: member, 1: admin, 2: owner
      t.integer :status, default: 0 # 0: pending, 1: accepted, 2: rejected

      t.timestamps
    end
    add_index :memberships, [:user_id, :research_group_id], unique: true
  end
end
