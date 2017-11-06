FactoryBot.define do
  factory :order_item do
    unit_price Faker::Number.decimal(2)
    quantity Faker::Number.number(2)
    order
  end
end
