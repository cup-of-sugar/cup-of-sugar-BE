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
          update_lend_posting(item, params[:user_id])
        else
          update_borrow_posting(item, params[:user_id])
        end
        item
      end

      private

        def update_lend_posting(item, user_id)
          if item.posting.responder_id.to_s == user_id && item.available == false
            # responder_id is equal to borrower
            item.update(available: !item.available)
          else
            item.update(available: !item.available)
            item.posting.update(responder_id: user_id)
            # do we care about overwriting responder_ids each time because if we do, we can't save a history of how many people have borrowed this same item
          end
        end

        def update_borrow_posting(item, user_id)
          if item.posting.poster_id.to_s == user_id && item.available == false
            item.update(available: !item.available)
          else
            item.posting.update(responder_id: user_id)
          end
        end
    end
  end
end
