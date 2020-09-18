FactoryBot.define do
  factory :item do
    item_name               { Faker::Lorem.sentence }
    text                    { Faker::Lorem.sentence }
    category_id             { Faker::Number.within(range: 2..11) }
    product_status_id       { Faker::Number.within(range: 2..7) }
    shipping_fee_status_id  { Faker::Number.within(range: 2..3) }
    prefecture_id           { Faker::Number.within(range: 2..48) }
    scheduled_delivery_id   { Faker::Number.within(range: 2..4) }
    price                   { Faker::Number.within(range: 300..9_999_999) }
    association :user
  end
end
