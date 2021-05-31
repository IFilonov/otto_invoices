FactoryBot.define do
  factory :invoice_operation do
    ParcelCode { "0123456789#{rand(1e4.to_i..1e5.to_i)}" }
    ItemQty { rand(50) }
    ParcelPrice { '9.99' }
    association :invoice
  end
end
