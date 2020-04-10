module Mutations
  module Postings
    class CreatePosting < ::Mutations::BaseMutation
      argument :category_name, String, required: true
      argument :name, String, required: true
      argument :description, String, required: false
      argument :time_duration, String, required: false
      argument :quantity, String, required: true
      argument :measurement, String, required: false

      field :category_name, String, null: false
      field :name, String, null: false
      field :description, String, null: true
      field :time_duration, String, null: true
      field :quantity, Float, null: false
      field :measurement, String, null: true

      def resolve(params)
        category = Category.find_by(name: params[:category_name])

        if category.name == 'Food'
          category.items.create(name: params[:name], description: params[:description], quantity: params[:quantity], measurement: params[:measurement], returnable: false)
        else
          category.items.create(name: params[:name], description: params[:description], quantity: params[:quantity], time_duration: params[:time_duration])
        end
        item = Item.last
        Posting.create(item_id: item.id)
        item
      end
    end
  end
end