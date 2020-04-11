class RenameTypeToPostingType < ActiveRecord::Migration[6.0]
  def change
    rename_column :postings, :type, :posting_type
  end
end
