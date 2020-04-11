class AddPostingsToItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :items, :posting, null: false, foreign_key: true
  end
end
