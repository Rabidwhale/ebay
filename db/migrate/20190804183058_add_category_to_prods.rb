class AddCategoryToProds < ActiveRecord::Migration[5.2]
  def change
    add_column :prods, :category_id, :integer
    add_index :prods, :category_id
  end
end
