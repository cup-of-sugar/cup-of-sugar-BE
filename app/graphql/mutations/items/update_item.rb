module Mutations
  module Items
    class UpdateItem < ::Mutations::BaseMutation

      argument :id, ID, required: true
      argument :available, Boolean, required: true
      argument :name, String, required: true

      field :id, ID, null: false
      field :available, Boolean, null: false
      field :name, String, null: false
    

      def resolve(params)
        item = Item.find(params[:id])
        item.available = !item.available
        item
      end
    end
  end
end
