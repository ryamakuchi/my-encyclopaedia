Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  # devise_for :users, skip: [:registrations], controllers: {
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }

  # devise_scope :user do
  #   get 'users/sign_up' => 'users/registrations#new', as: :new_user_registration
  #   get 'users/edit' => 'users/registrations#edit', as: :edit_user_registration
  #   # get 'users/cancel' => 'users/registrations#cancel', as: :cancel_user_registration
  #   post 'users' => 'users/registrations#create', as: :user_registration
  #   put 'users/edit' => 'users/registrations#update', as: :update_user_registration
  #   patch 'users/edit' => 'users/registrations#update_password', as: :update_user_password
  #   delete 'users/edit' => 'users/registrations#destroy', as: :destroy_user_registration
  # end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
