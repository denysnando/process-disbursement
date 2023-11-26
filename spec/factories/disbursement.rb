# frozen_string_literal: true

FactoryBot.define do
  factory :disbursement do
    merchant
    amount { 0 }
    amount_without_tax { 0 }
    year { Time.current.year }
    week { 5 }
  end
end
