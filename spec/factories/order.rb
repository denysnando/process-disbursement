# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    amount { 10 }
    identifier { Faker::IDNumber.valid }
    merchant_reference { Faker::IDNumber.valid }
  end
end
