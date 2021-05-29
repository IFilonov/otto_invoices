FactoryBot.define do
  factory :invoice_operation do
    ParcelCode { 'MyString' }
    ItemQty { 1 }
    ParcelPrice { '9.99' }
    invoice { nil }
  end
end
