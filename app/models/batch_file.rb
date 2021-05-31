class BatchFile < ApplicationRecord
  has_many :invoices, dependent: :destroy
  validates :guid, :batch_id, presence: true
  validates :guid, :batch_id, uniqueness: true
  validates :batch_id,
            numericality: { greater_than_or_equal_to: 1e6.to_i, less_than: 1e8.to_i,
                            only_integer: true }
end
