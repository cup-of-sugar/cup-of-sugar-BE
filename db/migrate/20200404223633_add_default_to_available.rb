class AddDefaultToAvailable < ActiveRecord::Migration[6.0]
  def change
    change_column :items, :available?, :boolean, default: true
  end
end
