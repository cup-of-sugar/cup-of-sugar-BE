class ChangeStatusToAvailable < ActiveRecord::Migration[6.0]
  def change
    rename_column :items, :status, :available?
  end
end
