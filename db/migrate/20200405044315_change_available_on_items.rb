class ChangeAvailableOnItems < ActiveRecord::Migration[6.0]
  def change
    rename_column :items, :available?, :available
  end
end
