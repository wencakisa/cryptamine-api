class CreateDecryptedMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :decrypted_messages do |t|
      t.string :message
      t.references :rsa, foreign_key: true

      t.timestamps
    end
  end
end
