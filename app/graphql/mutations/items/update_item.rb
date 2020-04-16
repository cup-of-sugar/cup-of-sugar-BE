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
        if item.posting.posting_type == "lend"
          update_lend_posting(item, context[:current_user].id)
        else
          update_borrow_posting(item, context[:current_user].id)
        end
      end

      private

        def update_lend_posting(item, user_id)
          return unless item.posting.poster_id != user_id
          if item.posting.responder_id == user_id && item.available == false
            item.update(available: !item.available)
          else
            item.update(available: !item.available)
            item.posting.update(responder_id: user_id)
          end
          item
        end

        def update_borrow_posting(item, user_id)
          if item.posting.poster_id == user_id && item.available == false
            item.update(available: !item.available)
          else
            return unless item.posting.poster_id != user_id
            item.posting.update(responder_id: user_id)
          end
          item
        end
    end
  end
end
