class AlterProdsAddUserId < ActiveRecord::Migration[5.2]
  def change
    add_column :prods, :user_id, :integer
    add_index :prods, :user_id
  end
end
