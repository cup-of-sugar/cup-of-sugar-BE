FactoryBot.define do
  factory :message do
    body { "MyString" }
    sender_id { 1 }
    recipient_id { 1 }
  end
end
