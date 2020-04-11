class AddTitleToPosting < ActiveRecord::Migration[6.0]
  def change
    add_column :postings, :title, :string
  end
end
