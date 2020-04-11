class AddTypeToPostings < ActiveRecord::Migration[6.0]
  def change
    add_column :postings, :type, :integer
  end
end
