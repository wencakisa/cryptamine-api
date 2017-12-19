class DecryptedMessagesController < AbstractMessagesController
  def rsa_messages
    @rsa.decrypted_messages
  end

  def evaluated_message
    @rsa.decrypt message_params
  end
end
