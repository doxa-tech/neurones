Neurones::Application.routes.draw do

  mount Mercury::Engine => '/'

  root to: 'pages#home'
  match '/blog', to: 'articles#index'
  match '/home', to: 'pages#home'
  match '/presentation', to: 'pages#presentation'
  match '/contact', to: 'pages#contact'
  match '/catalogue', to: 'groups#index'

  match '/login', to: 'sessions#login'
  match '/login-plus', to: 'sessions#plus'

  match '/connexion', to: 'sessions#new'
  match '/deconnexion', to: 'sessions#destroy', via: :delete

  resources :galleries, only: [:index, :show], path: '/medias'
  resources :events, only: [:index, :show], path: '/programme'

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
  		resources :mercury_images, only: [:index, :create, :destroy]
  		resources :groups, except: [:show]

  	end

  	resources :sessions, only: [:create, :destroy]

  end
end
