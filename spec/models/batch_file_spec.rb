require 'rails_helper'

RSpec.describe BatchFile, type: :model do
  describe 'validations' do
    it { is_expected.to have_many(:invoices).dependent(:destroy) }

    it { is_expected.to have_db_index :guid }
    it { is_expected.to have_db_index :batch_id }
    it { is_expected.to validate_presence_of :batch_id }

    it {
      expect(subject).to validate_numericality_of(:batch_id).is_greater_than_or_equal_to(1e6.to_i).is_less_than(1e8.to_i).only_integer
    }

    describe 'uniqueness' do
      subject { FactoryBot.build(:batch_file) }

      it { is_expected.to validate_uniqueness_of :guid }
      it { is_expected.to validate_uniqueness_of :batch_id }
    end
  end

  describe 'is valid with' do
    let!(:batch_file) { create(:batch_file) }

    it 'valid attributes' do
      expect(described_class.count).to eq(1)
    end
  end

  describe 'does not allow create another file with' do
    let!(:batch_file) { create(:batch_file) }

    error = 'has already been taken'
    it 'same guid' do
      same_guid_file = described_class.create(guid: batch_file.guid, batch_id: 1_234_567)
      expect(same_guid_file.errors.messages[:guid].first).to eq(error)
    end

    it 'same batch_id' do
      same_batch_file = described_class.create(guid: '01234567890ABCFEF',
                                               batch_id: batch_file.batch_id)
      expect(same_batch_file.errors.messages[:batch_id].first).to eq(error)
    end
  end
end
