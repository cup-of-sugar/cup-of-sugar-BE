module Mutations
  module Postings
    class CreatePosting < ::Mutations::BaseMutation
      argument :title, String, required: true
      argument :posting_type, String, required: true
      argument :category_name, String, required: true
      argument :name, String, required: true
      argument :description, String, required: false
      argument :time_duration, String, required: false
      argument :quantity, String, required: true
      argument :measurement, String, required: false
      argument :user_id, ID, required: true

      field :posting_type, String, null: false
      field :category_name, String, null: false
      field :name, String, null: false
      field :description, String, null: true
      field :time_duration, String, null: true
      field :quantity, Float, null: false
      field :measurement, String, null: true


      def resolve(params)
        posting = Posting.create(posting_type: params[:posting_type], title: params[:title], poster_id: params[:user_id])
        create_item(params, posting.id)
      end

      private
        def create_item(params, posting_id)
          category = Category.find_by(name: params[:category_name])
          item = category.items.create(name: params[:name], description: params[:description], quantity: params[:quantity], posting_id: posting_id)
          update_item(item, params)
        end

        def update_item(item, params)
          if item.category.name == "Food"
            update_item_in_food_category(item, params)
          else
            update_item_in_other_category(item, params)
          end
          update_borrowed_item_availability(item)
          item
        end

        def update_item_in_other_category(item, params)
          item.update(time_duration: params[:time_duration])
        end

        def update_item_in_food_category(item, params)
          item.update(returnable: false, measurement: params[:measurement])
        end

        def update_borrowed_item_availability(item)
          if item.posting.posting_type == "borrow"
            item.update(available: false)
          end
        end
    end
  end
end
