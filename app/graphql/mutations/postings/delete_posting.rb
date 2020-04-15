module Mutations
  module Postings
    class DeletePosting < ::Mutations::BaseMutation
      argument :id, ID, required: true

      field :posting, Types::PostingType, null: false
      field :title, String, null: false

      def resolve(id: )
        if Posting.find(id).responder_id == nil && Posting.find(id).destroy
          { title: "successfully deleted" }
        else
          Posting.find(id)
        end
      end
    end
  end
end
