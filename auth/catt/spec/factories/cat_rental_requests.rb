FactoryBot.define do
  factory :cat_rental_request do
    cat_id { 1 }
    start_date { "2021-09-14" }
    end_date { "2021-09-14" }
    status { "MyString" }
  end
end
