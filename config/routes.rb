Rails.application.routes.draw do
  resources :companies
  resources :nominees
  resources :nominations do
    collection do
      get '/load_rating_form/:award_id/(:nomination_id)' => 'nominations#load_rating_form'
    end
    member do
      post 'push_back'
      post 'forward'
      post 'l1_approval'
      post 'l2_approval'
      get 'justification'
      post 'reject_single_nominee'
      post 'chairman_approval'
    end
  end
  
  get '/nominations/:id/pushback' => 'nominations#pushback'
  get '/team_nominations/new' => 'nominations#team_nomination'
  get '/individual_nominations/:type' => 'nominations#individual_nominations'
  post '/awards/:id/add_comment_to_award' => 'award#add_comment_to_award'

  resources :award_masters
  resources :cycles
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homes#index"
  get '/l1_dashboard' => 'homes#l1_dashboard'
  get '/l2_dashboard' => 'homes#l2_dashboard'
  get '/chairman_dashboard' => 'homes#chairman_dashboard'
  get '/user_dashboard' => 'homes#user_dashboard'
end
