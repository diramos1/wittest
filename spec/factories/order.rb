FactoryBot.define do
  factory :order do
    status Faker::Number.between(0, 2)
    total Faker::Number.decimal(2)
  end
end
