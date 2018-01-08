FactoryBot.define do
  factory :encrypted_message do
    message { Faker::RickAndMorty.quote }
    rsa_id nil
  end
end
