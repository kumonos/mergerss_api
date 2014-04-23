Rails.application.routes.draw do
  get 'members/show'

  # ActiveAdmin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Merge RSS API
  get '/api/1/articles.json', controller: :articles, action: :index
  get '/api/1/members/:id.json', controller: :members, action: :show

  # Demo
  get '/demo', controller: :demo, action: :index
end
