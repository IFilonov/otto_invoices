class InvoiceOperation < ApplicationRecord
  belongs_to :invoice
  validates :ParcelCode, :ItemQty, :ParcelPrice, presence: true
  validates :ParcelCode, length: { is: 15 }
  validates :ItemQty, numericality: { less_than_or_equal_to: 50, only_integer: true }
  validates :ParcelPrice, numericality: { less_than_or_equal_to: 90000 }
end
