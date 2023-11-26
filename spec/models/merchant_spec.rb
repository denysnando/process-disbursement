# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Merchant do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:disbursement_frequency) }
    it { is_expected.to validate_presence_of(:reference) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to allow_value('test@example.com').for(:email) }
    it { is_expected.not_to allow_value('invalid_email').for(:email) }
    it { is_expected.to validate_numericality_of(:minimum_monthly_fee) }
  end
end
