FactoryBot.define do
  factory :rsa do
    n { Rsa.new_keys[:n] }
    e { Rsa.new_keys[:e] }
    d { Rsa.new_keys[:d] }
  end
end
