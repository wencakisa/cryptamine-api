FactoryBot.define do
  factory :decrypted_message do
    message { Faker::RickAndMorty.quote }
    rsa_id nil
  end
end
