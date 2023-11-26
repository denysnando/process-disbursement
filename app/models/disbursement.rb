# frozen_string_literal: true

class Disbursement < ApplicationRecord
  # Relationship
  belongs_to :merchant

  # Validations
  validates :year, :week, numericality: { only_integer: true }
  validates :amount, :amount_without_tax, numericality: true

  # Validations
  scope :year, ->(year) { where(year:) }
end
