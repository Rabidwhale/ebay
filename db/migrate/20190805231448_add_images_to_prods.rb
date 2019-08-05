class AddImagesToProds < ActiveRecord::Migration[5.2]
  def change
    add_column :prods, :images, :json
  end
end
