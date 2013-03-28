Neurones::Application.routes.draw do
  
  mount Mercury::Engine => '/'

  root to: 'pages#home'

  match '/home', to: 'pages#home'

  match '/connexion', to: 'sessions#new'
  match '/deconnexion', to: 'sessions#destroy', via: :delete

  resources :galleries, only: [:index, :show], path: '/medias'

  scope(:path_names => { :new => "nouveau", :edit => "edition" }) do

  	namespace :admin do

  		resources :users, except: [:show]
  		match '/profil', to: 'users#profile'

  		resources :pages do 
        member { post :mercury_update }
      end
  		resources :events, except: [:show]
  		resources :articles, except: [:show]
  		resources :galleries, except: [:show] do 
  			resources :paintings, except: [:index, :show]
  		end
  		resources :images, except: [:show]
  		resources :slideshows, except: [:show]

  	end

  	resources :sessions, only: [:create, :destroy]

  end
end
