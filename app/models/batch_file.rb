class BatchFile < ApplicationRecord
  has_many :invoices, dependent: :destroy
  validates :guid, :batch_id, presence: true
  validates :guid, :batch_id, uniqueness: true
  validates :batch_id, numericality: true
  validates :batch_id, length: { is: 7 }
end
