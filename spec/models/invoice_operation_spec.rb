require 'rails_helper'

RSpec.describe InvoiceOperation, type: :model do
  describe 'validations' do
    it { is_expected.to belong_to(:invoice) }

    it { is_expected.to have_db_index :ParcelCode }
    it { is_expected.to have_db_index :invoice_id }

    it { is_expected.to validate_presence_of :ParcelCode }
    it { is_expected.to validate_presence_of :ItemQty }
    it { is_expected.to validate_presence_of :ParcelPrice }

    it {
      expect(subject).to validate_numericality_of(:ItemQty).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(50).only_integer
    }

    it {
      expect(subject).to validate_numericality_of(:ParcelPrice).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(9e4)
    }

    it { expect(subject).not_to allow_value('abc123').for(:ParcelCode) }
    it { expect(subject).not_to allow_value('123').for(:ParcelCode) }
    it { expect(subject).to allow_value('000123456789012').for(:ParcelCode) }
    it { expect(subject).not_to allow_value('0001234567890123').for(:ParcelCode) }
  end

  describe 'uniq validations' do
    subject { FactoryBot.build(:invoice_operation) }

    it { is_expected.to validate_uniqueness_of(:ParcelCode).ignoring_case_sensitivity }
  end
end
