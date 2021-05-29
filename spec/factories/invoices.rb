FactoryBot.define do
  factory :invoice do
    InvoiceOperationNumber { 1 }
    InvoiceOperationDate { '2021-05-29' }
    CompanyCode { 1 }
    batch_file { nil }
  end
end
