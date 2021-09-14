FactoryBot.define do
  factory :user do
    password_digest { "MyString" }
    session_token { "MyString" }
    username { "MyString" }
  end
end
