require 'rails_helper'

shared_examples_for 'messagable' do
  context 'associations' do
    it { should belong_to(:rsa) }
  end

  context 'validations' do
    it { should validate_presence_of(:message) }
  end
end
