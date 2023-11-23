# frozen_string_literal: true

FactoryBot.define do
  factory :disbursement do
    amount_disbursed { 0 }
    amount_of_orders { 0 }
    amount_monthly_fee_charged { 0 }
    counter_disbursed { 0 }
    counter_monthly_fee_charged { 0 }
    year { Time.current.year }
  end
end
