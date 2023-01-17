FactoryBot.define do
  factory :address_form do
    zip_code              { Faker::Number.decimal_part(digits: 3) + '-' + Faker::Number.decimal_part(digits: 4) }
    prefecture_id          { Faker::Number.between(from: 1, to: 47) }
    city                   { Faker::Address.city }
    block_number                { Faker::Address.street_address }
    apartment_name               { Faker::Address.street_address }
    phone_number           { Faker::Number.decimal_part(digits: 11) }
    token                  { Faker::Internet.password(min_length: 20, max_length: 30) }
    
    association :user_id
    association :item_id
  end
end