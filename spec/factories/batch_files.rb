FactoryBot.define do
  factory :batch_file do
    guid { "16BA036FCC3D4AF7E05378A06D0AD#{rand(1e2.to_i..1e3.to_i)}" }
    batch_id { rand(1e6.to_i..1e7.to_i) }
  end
end
