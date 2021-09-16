FactoryBot.define do
  factory :cat do
    
    color { Faker::Color.hex_color }
    name { Faker::Name.name } 

    

  end
end
