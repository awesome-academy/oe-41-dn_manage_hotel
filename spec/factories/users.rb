FactoryBot.define do
  factory :user do
     name        { Faker::Name.name }
     email       { Faker::Internet.email }
     address     { Faker::Address.street_address }
     id_card     {"123456789"}
     birthday    {Faker::Date.birthday(min_age: 18, max_age: 65)}
     password    {"123456"}
     password_confirmation {"123456"}
  end
end
