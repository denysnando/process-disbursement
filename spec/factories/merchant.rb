# frozen_string_literal: true

FactoryBot.define do
  factory :merchant do
    email { Faker::Internet.email }
    reference { Faker::IDNumber.valid }
    disbursement_frequency { 'DAILY' }
    minimum_monthly_fee { 1.5 }
    live_on { Faker::Date.between(from: 2.days.ago, to: Time.zone.today) }

    trait :weekly do
      disbursement_frequency { 'WEEKLY' }
    end
  end
end
