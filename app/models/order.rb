# frozen_string_literal: true

class Order < ApplicationRecord
  TIER_1_LIMIT = 50
  TIER_2_LIMIT = 300

  TIER_1_FEE = 0.01
  TIER_2_FEE = 0.0095
  TIER_3_FEE = 0.0085

  # Validations
  validates :amount, presence: true, numericality: { greater_than: 0 }

  def net_amount
    amount - calculate_fee_amount.round(2)
  end

  def calculate_fee_amount
    amount * fee_percentage
  end

  def fee_percentage
    if amount < TIER_1_LIMIT
      TIER_1_FEE
    elsif amount < TIER_2_LIMIT
      TIER_2_FEE
    else
      TIER_3_FEE
    end
  end
end
