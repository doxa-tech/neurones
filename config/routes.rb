Neurones::Application.routes.draw do
  
  get "paintings/new"

  root to: 'pages#home'

  match '/home', to: 'pages#home'

  match '/connexion', to: 'sessions#new'
  match '/deconnexion', to: 'sessions#destroy', via: :delete

  scope(:path_names => { :new => "nouveau", :edit => "edition" }) do

  	namespace :admin do

  		resources :users, except: [:show]
  		match '/profil', to: 'users#profile'

  		resources :pages, except: [:show]
  		resources :events, except: [:show]
  		resources :articles, except: [:show]
  		resources :galleries, except: [:show] do 
  			resources :paintings, except: [:index, :show]
  		end

  	end

  	resources :sessions, only: [:create, :destroy]

  end
end
