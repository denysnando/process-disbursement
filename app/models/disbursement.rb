# frozen_string_literal: true

class Disbursement < ApplicationRecord

  # Validations
  validates :year, :counter_disbursed, :counter_monthly_fee_charged, numericality: { only_integer: true }
  validates :amount_disbursed, :amount_of_orders, :amount_monthly_fee_charged, numericality: true

  # Validations
  scope :year, ->(year) { where(year:) }
end
