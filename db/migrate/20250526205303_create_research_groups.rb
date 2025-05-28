class CreateResearchGroups < ActiveRecord::Migration[7.2]
  def change
    create_table :research_groups do |t|
      t.string :name
      t.text :description
      t.integer :visibility, default: 0 # 0: private, 1: public
      t.references :admin, null: false, foreign_key: { to_table: :users } # Garante que o admin seja um User

      t.timestamps
    end
  end
end
