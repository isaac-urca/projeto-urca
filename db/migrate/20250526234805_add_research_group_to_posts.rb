class AddResearchGroupToPosts < ActiveRecord::Migration[7.2]
  def change
    add_reference :posts, :research_group, null: true, foreign_key: true
  end
end
