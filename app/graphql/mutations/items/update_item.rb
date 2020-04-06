module Mutations
  module Items
    class UpdateItem < ::Mutations::BaseMutation

      argument :id, ID, required: true
      argument :available, Boolean, required: true
      argument :name, String, required: true

      type Types::ItemType

      def resolve(params)
        item = Item.find(params[:id])
        item.available = !item.available
      end
    end
  end
end
