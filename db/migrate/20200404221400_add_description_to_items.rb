class AddDescriptionToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :description, :string
  end
end
