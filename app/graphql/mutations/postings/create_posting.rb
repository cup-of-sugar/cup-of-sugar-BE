module Mutations
  module Postings
    class CreatePosting < ::Mutations::BaseMutation
      argument :posting_type, String, required: true
      argument :category_name, String, required: true
      argument :name, String, required: true
      argument :description, String, required: false
      argument :time_duration, String, required: false
      argument :quantity, String, required: true
      argument :measurement, String, required: false

      field :posting_type, String, null: false
      field :category_name, String, null: false
      field :name, String, null: false
      field :description, String, null: true
      field :time_duration, String, null: true
      field :quantity, Float, null: false
      field :measurement, String, null: true


      def resolve(params)
        category = Category.find_by(name: params[:category_name])
        user = User.first


        if category.name == 'Food'
          category.items.create(name: params[:name], description: params[:description], quantity: params[:quantity], measurement: params[:measurement], returnable: false, user_id: user.id)
        else
          category.items.create(name: params[:name], description: params[:description], quantity: params[:quantity], time_duration: params[:time_duration], user_id: user.id)
        end
        item = Item.last
        Posting.create(item_id: item.id, posting_type: params[:posting_type])
        item
      end
    end
  end
end
