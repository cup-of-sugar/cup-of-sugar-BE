module Mutations
  module Items
    class UpdateItem < ::Mutations::BaseMutation
      argument :id, ID, required: true
      argument :user_id, ID, required: true
      argument :available, Boolean, required: true
      argument :name, String, required: true

      field :id, ID, null: false
      field :available, Boolean, null: false
      field :name, String, null: false


      def resolve(params)
        item = Item.find(params[:id])

        if item.posting.posting_type == "lend"
          if item.posting.responder_id.to_s == params[:user_id] && item.available == false
            # responder_id is equal to borrower
            item.update(available: !item.available)
          else
            item.update(available: !item.available)
            item.posting.update(responder_id: params[:user_id])
            # do we care about overwriting responder_ids each time because if we do, we can't save a history of how many people have borrowed this same item.
          end
        else
          if item.posting.poster_id.to_s == params[:user_id] && item.available == false
            item.update(available: !item.available)
          else
            item.posting.update(responder_id: params[:user_id])
            # require "pry"; binding.pry
          end
        end
        item
      end
    end
  end
end
