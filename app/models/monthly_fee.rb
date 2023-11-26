# frozen_string_literal: true

class MonthlyFee < ApplicationRecord
  # Relationship
  belongs_to :merchant

  # Validations
  validates :year, :month, numericality: { only_integer: true }
  validates :amount, numericality: true
end
