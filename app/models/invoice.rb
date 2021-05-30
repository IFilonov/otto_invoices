class Invoice < ApplicationRecord
  belongs_to :batch_file
  has_many :invoice_operations, dependent: :destroy
  validates :InvoiceOperationNumber, :InvoiceOperationDate, :CompanyCode, presence: true
  validates :InvoiceOperationNumber, uniqueness: true
  validates :InvoiceOperationNumber,
            numericality: { greater_than_or_equal_to: 0, less_than: 1e10.to_i, only_integer: true }
  validates :CompanyCode,
            numericality: { greater_than_or_equal_to: 1e3.to_i, less_than: 1e5.to_i,
                            only_integer: true }
end
