FactoryBot.define do
  factory :customer do
     name        { Faker::Name.name }
     address       { Faker::Address.street_address }
     id_card {"12345678"}
     birthday  {Faker::Date.birthday(min_age: 17, max_age: 66)}
  end
end
