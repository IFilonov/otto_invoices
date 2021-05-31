class InvoiceOperation < ApplicationRecord
  belongs_to :invoice
  validates :ParcelCode, :ItemQty, :ParcelPrice, presence: true
  validates :ParcelCode,
            format: { with: /\A\d{15}\z/, message: 'Only 15 digits are possible in ParcelCode' }
  validates :ParcelCode, uniqueness: true
  validates :ItemQty,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 50,
                            only_integer: true }
  validates :ParcelPrice, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 9e4 }
  validate :max_parcels, on: :create

  def max_parcels
    err_msg = 'Cannot add more then 10 parcels'
    return unless invoice && invoice.invoice_operations.count >= 10

    errors.add(:invoice_id, :too_many_parcels,
               message: err_msg)
  end
end
