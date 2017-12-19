Rails.application.routes.draw do
  get 'rsas/new_key' => 'rsas#new_key'

  resources :rsas do
    resources :encrypted_messages
    resources :decrypted_messages
  end
end
