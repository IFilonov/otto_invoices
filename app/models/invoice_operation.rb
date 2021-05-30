class InvoiceOperation < ApplicationRecord
  belongs_to :invoice
  validates :ParcelCode, :ItemQty, :ParcelPrice, presence: true
  validates :ParcelCode,
            format: { with: /\A\d{15}\z/, message: 'Only 15 digits are possible in ParcelCode' }
  validates :ItemQty, numericality: { less_than_or_equal_to: 50, only_integer: true }
  validates :ParcelPrice, numericality: { less_than_or_equal_to: 90_000 }
  validate :max_parcels, on: :create

  def max_parcels
    err_msg = 'Cannot add more then 10 parcels'
    errors.add(:invoice_id, :too_many_parcels, message: err_msg) if invoice && invoice.invoice_operations.count >= 10
  end
end
