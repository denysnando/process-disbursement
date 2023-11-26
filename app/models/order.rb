# frozen_string_literal: true

class Order < ApplicationRecord
  TIER_1_LIMIT = 50
  TIER_2_LIMIT = 300

  TIER_1_FEE = 0.01
  TIER_2_FEE = 0.0095
  TIER_3_FEE = 0.0085

  # Relationships
  belongs_to :disbursement, optional: true

  # Validations
  validates :amount, presence: true, numericality: { greater_than: 0 }

  scope :completed, -> { where.not(completed_at: nil) }
  scope :incompleted, -> { where(completed_at: nil) }

  scope :completed_in_week, lambda { |year, week|
    start_of_week = Date.commercial(year, week).beginning_of_week.beginning_of_day
    end_of_week = Date.commercial(year, week).end_of_week.end_of_day
    where(completed_at: start_of_week..end_of_week)
  }

  def net_amount
    amount - calculate_fee_amount
  end

  def calculate_fee_amount
    (amount * fee_percentage).round(2)
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
