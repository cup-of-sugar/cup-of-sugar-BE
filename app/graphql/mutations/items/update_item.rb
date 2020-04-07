module Mutations
  module Items
    class UpdateItem < ::Mutations::BaseMutation

      argument :id, ID, required: true
      argument :available, Boolean, required: true
      argument :name, String, required: true

<<<<<<< HEAD
      field :id, ID, null: false
      field :available, Boolean, null: false
      field :name, String, null: false
=======
      type Types::ItemType
>>>>>>> 93d9815cd3c9b10cb36aa366cc60d095d7b80594

      def resolve(params)
        item = Item.find(params[:id])
        item.available = !item.available
<<<<<<< HEAD
        item
=======
>>>>>>> 93d9815cd3c9b10cb36aa366cc60d095d7b80594
      end
    end
  end
end
