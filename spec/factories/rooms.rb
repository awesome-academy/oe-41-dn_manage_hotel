FactoryBot.define do
  factory :room do
     name         { Faker::Name.name }
     price        { 500 }
  end
end
