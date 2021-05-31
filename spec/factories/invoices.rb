FactoryBot.define do
  factory :invoice do
    InvoiceOperationNumber { 1 }
    InvoiceOperationDate { '2021-05-29' }
    CompanyCode { 4567 }
    association :batch_file
  end
end
