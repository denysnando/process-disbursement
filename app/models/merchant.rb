# frozen_string_literal: true

class Merchant < ApplicationRecord
  # REGEX
  VALID_EMAIL_REGEX = /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/

  # Relationship
  has_many :disbursements, dependent: :destroy

  # Validations
  validates :reference, :disbursement_frequency, presence: true
  validates :minimum_monthly_fee, numericality: true
  validates :reference, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
end
