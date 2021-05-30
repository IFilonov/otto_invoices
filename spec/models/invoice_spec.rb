require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'validations' do
    it { is_expected.to belong_to(:batch_file) }
    it { is_expected.to have_many(:invoice_operations).dependent(:destroy) }

    it { is_expected.to have_db_index :InvoiceOperationNumber }
    it { is_expected.to have_db_index :batch_file_id }

    it { is_expected.to validate_presence_of :InvoiceOperationNumber }
    it { is_expected.to validate_presence_of :InvoiceOperationDate }
    it { is_expected.to validate_presence_of :CompanyCode }

    it {
      expect(subject).to validate_numericality_of(:InvoiceOperationNumber).is_greater_than_or_equal_to(0).is_less_than(1e10.to_i).only_integer
    }

    it {
      expect(subject).to validate_numericality_of(:CompanyCode).is_greater_than_or_equal_to(1e3.to_i).is_less_than(1e5.to_i).only_integer
    }

    describe 'uniq validations' do
      subject { FactoryBot.build(:invoice) }

      it { is_expected.to validate_uniqueness_of :InvoiceOperationNumber }
    end
  end
end
