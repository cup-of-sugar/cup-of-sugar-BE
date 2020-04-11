class RemoveItemIdFromPostings < ActiveRecord::Migration[6.0]
  def change
    remove_column :postings, :item_id
  end
end
