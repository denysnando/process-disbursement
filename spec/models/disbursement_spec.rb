# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Disbursement do
  describe 'validations' do
    subject { build(:merchant) } # Assuming you have FactoryBot for creating test objects

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:disbursement_frequency) }
    it { is_expected.to validate_presence_of(:reference) }
    it { is_expected.to validate_uniqueness_of(:reference).case_insensitive }
    it { is_expected.to allow_value('test@example.com').for(:email) }
    it { is_expected.not_to allow_value('invalid_email').for(:email) }
    it { is_expected.to validate_numericality_of(:minimum_monthly_fee) }
  end

  describe 'scopes' do
    describe '.year' do
      it 'filters by year' do
        disbursement = create(:disbursement, year: 2019)
        create(:disbursement, year: 2020)

        expect(described_class.year(2019)).to eq([disbursement])
      end
    end
  end
end
