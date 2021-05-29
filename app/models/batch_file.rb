class BatchFile < ApplicationRecord
  has_many :invoices, dependent: :destroy
end
