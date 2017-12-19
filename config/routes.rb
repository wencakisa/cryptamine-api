Rails.application.routes.draw do
  get 'rsas/new_keys' => 'rsas#new_keys'

  resources :rsas do
    resources :encrypted_messages
    resources :decrypted_messages
  end
end
