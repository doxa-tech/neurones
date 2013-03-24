Neurones::Application.routes.draw do
  
  root to: 'pages#home'

  match '/home', to: 'pages#home'

  match '/connexion', to: 'sessions#new'
  match '/deconnexion', to: 'sessions#destroy', via: :delete

  scope(:path_names => { :new => "nouveau", :edit => "edition" }) do

  	namespace :admin do

  		resources :users
  		match '/profil', to: 'users#profile'

  	end

  	resources :sessions, only: [:create, :destroy]

  end
end
