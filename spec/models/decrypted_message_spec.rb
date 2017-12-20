require 'rails_helper'

RSpec.describe DecryptedMessage, type: :model do
  context "associations" do
    it { should belong_to(:rsa) }
  end

  context "validations" do
    it { should validate_presence_of(:message) }
  end
end
