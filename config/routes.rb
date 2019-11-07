Rails.application.routes.draw do
  resources :nominees
  resources :nominations do
    collection do
      get '/load_rating_form/:award_id' => 'nominations#load_rating_form'
    end
  end
  get '/team_nominations/new' => 'nominations#team_nomination'
  resources :award_masters
  resources :cycles
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homes#index"
  get '/l1_dashboard' => 'homes#l1_dashboard'
  get '/l2_dashboard' => 'homes#l2_dashboard'
  get '/chairman_dashboard' => 'homes#chairman_dashboard'
end
