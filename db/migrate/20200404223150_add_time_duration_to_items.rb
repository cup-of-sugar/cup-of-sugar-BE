class AddTimeDurationToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :time_duration, :string
  end
end
