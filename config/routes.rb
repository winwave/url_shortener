# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  post '/authenticate', to: 'authentication#authenticate'
  post 'api/shorten', to: 'api/url_short_links#create'
  get '/:shorten_id', to: 'api/url_short_links#show'
end
