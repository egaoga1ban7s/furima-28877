FactoryBot.define do
  factory :order_address do
    transient do
      person  { Gimei.name }
      address { Gimei.address }
    end
    token         { '71HotsgmOM3aUkQlRcNwzpu0rw6G9HYwGARh6fkLX09JYZ6kbS9SmcAakB9UfUUcImRFAl6T4ZaDM960xT8/4A==' }
    postal_code   { '123-4567' }
    prefecture_id { Faker::Number.within(range: 2..48) }
    city          { address.city.kanji }
    house_number  { address.town.kanji }
    building_name { '大町ビル101' }
    telephone     { Faker::Number.leading_zero_number(digits: 11) }
    user_id       { 2 }
    item_id       { 1 }
  end
end
