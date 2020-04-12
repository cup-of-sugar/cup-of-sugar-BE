class AddColumnsToPostings < ActiveRecord::Migration[6.0]
  def change
    add_column :postings, :poster_id, :integer
    add_column :postings, :responder_id, :integer
  end
end
