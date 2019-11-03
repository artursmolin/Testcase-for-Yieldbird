# frozen_string_literal: true

Rails.application.routes.draw do
  resources :tournaments do
    resources :divisions
    resources :teams
    resources :matches
    get 'playoff', to: 'tournaments#playoff'
    get 'quarterfinals', to: 'tournaments#quarterfinals'
    get 'semifinals', to: 'tournaments#semifinals'
    get 'final', to: 'tournaments#final'
    post 'divisions/round_robin', to: 'divisions#round_robin'
    post 'bo4', to: 'tournaments#bo4'
    post 'bo2', to: 'tournaments#bo2'
    post 'bo1', to: 'tournaments#bo1'
  end

  root to: 'tournaments#new'
end
