class Invoice < ApplicationRecord
  belongs_to :batch_file
  has_many :invoice_operations, dependent: :destroy
end
