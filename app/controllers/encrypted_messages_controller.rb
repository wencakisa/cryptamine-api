class EncryptedMessagesController < AbstractMessagesController
  def rsa_messages
    @rsa.encrypted_messages
  end

  def evaluated_message
    @rsa.encrypt message_params
  end
end
