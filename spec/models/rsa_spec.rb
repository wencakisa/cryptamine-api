require 'rails_helper'

RSpec.describe Rsa, type: :model do
  let!(:new_keys) { Rsa.new_keys }
  let(:rsa)       { Rsa.new new_keys }
  let(:message)   { 'Hello World!' }

  context '#new_keys' do
    it 'generates hash with three keys' do
      expect(new_keys).to be_an Hash
    end

    it 'generates hash including :n, :e and :d keys' do
      expect(new_keys).to include(:n, :e, :d)
    end

    it 'generates integer hash values' do
      expect(new_keys.values).to all be_an Integer
    end
  end

  context 'associations' do
    it { should have_many(:encrypted_messages) }
    it { should have_many(:decrypted_messages) }
  end

  context 'validations' do
    it { should validate_presence_of(:n) }
    it { should validate_presence_of(:e) }
    it { should validate_presence_of(:d) }
  end

  context '#encrypt' do
    it 'returns a string' do
      expect(rsa.encrypt(message)).to be_an String
    end

    it 'returns a string with the same length as the provided' do
      # As long as I use a delimiter, code will be awful :/
      encrypted_string = rsa.encrypt(message).split Rsa::DELIMITER
      expect(encrypted_string.size).to eq message.size
    end

    it 'returns a string different from the provided' do
      expect(rsa.encrypt(message)).to_not eq message
    end
  end

  context '#decrypt' do
    it 'returns a string' do
      expect(rsa.decrypt(message)).to be_an String
    end

    it 'returns a string different from the provided' do
      expect(rsa.decrypt(message)).to_not eq message
    end

    it 'decrypts encrypted message back to original one' do
      expect(rsa.decrypt(rsa.encrypt(message))).to eq message
    end
  end
end
