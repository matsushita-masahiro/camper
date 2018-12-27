class RemoveNumFromLikes < ActiveRecord::Migration[5.2]
  def change
    remove_column :likes, :num, :integer
  end
end
