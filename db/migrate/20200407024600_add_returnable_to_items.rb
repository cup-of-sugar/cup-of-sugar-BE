class AddReturnableToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :returnable, :boolean, default: true
  end
end
