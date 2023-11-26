# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MonthlyFee do
  describe 'relantionship' do
    it { is_expected.to belong_to(:merchant) }
  end

  describe 'validations' do
    it { is_expected.to validate_numericality_of(:year).only_integer }
    it { is_expected.to validate_numericality_of(:month).only_integer }
    it { is_expected.to validate_numericality_of(:amount) }
  end
end
