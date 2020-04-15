module Mutations
  module Messages
    class SendMessage < ::Mutations::BaseMutation
      argument :title, String, required: true
      argument :body, String, required: true
      argument :userId, ID, required: true
      argument :recipientEmail, ID, required: true

      field :id, ID, null: false
      field :title, String, null: false
      field :body, String, null: false

      def resolve(params)
        Message.create(
          title: params[:title],
          body: params[:body],
          sender_id: params[:userId],
          recipient_id: User.find_by(email: params[:recipientEmail]).id)
      end
    end
  end
end
