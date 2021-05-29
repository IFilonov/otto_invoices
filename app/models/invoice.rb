class Invoice < ApplicationRecord
  belongs_to :batch_file
  has_many :invoice_operations, dependent: :destroy
  validates :InvoiceOperationNumber, :InvoiceOperationDate, :CompanyCode, presence: true
  validates :InvoiceOperationNumber, uniqueness: true
  validates :InvoiceOperationNumber, length: { in: 1..9 }
  validates :CompanyCode, numericality: true
  validates :CompanyCode, length: { is: 4 }
end
