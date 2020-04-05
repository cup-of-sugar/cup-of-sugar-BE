class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name
      t.float :quantity
      t.boolean :status

      t.timestamps
    end
  end
end
