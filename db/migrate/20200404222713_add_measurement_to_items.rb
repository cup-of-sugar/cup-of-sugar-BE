class AddMeasurementToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :measurement, :string
  end
end
