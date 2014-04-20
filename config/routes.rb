Rails.application.routes.draw do
  # ActiveAdmin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Merge RSS API
  get '/api/1/articles.json', controller: :articles, action: :index

  # Demo
  get '/demo', controller: :demo, action: :index
end
