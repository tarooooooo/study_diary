# frozen_string_literal: true

devise_for :users, controllers: {
  sessions: 'public/users/sessions',
  registrations: 'public/users/registrations',
  confirmations: 'public/users/confirmations',
  passwords: 'public/users/passwords'
}

namespace :public, path: '/' do
  root 'top_page#show'

  resources :study_categories, only: [:index, :create, :new, :destroy]
end
