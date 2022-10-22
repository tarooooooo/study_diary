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
  resources :learning_diaries, only: [:show, :index, :create, :new, :destroy]
  resources :study_plans, only: [:create]

  namespace :mypage do
    root 'top_page#show'
    resource :profile, only: %i[new create edit update]
  end
end
