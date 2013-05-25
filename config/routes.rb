Neurones::Application.routes.draw do

  mount Mercury::Engine => '/'

  root to: 'pages#home'
  match '/blog', to: 'articles#index'
  match '/home', to: 'pages#home'
  match '/presentation', to: 'pages#presentation'
  match '/contact', to: 'pages#contact'
  match '/catalogue', to: 'group::groups#index'

  match '/profil', to: 'users#show'
  match '/inscription', to: 'users#new'

  match '/login', to: 'sessions#login'
  match '/login-plus', to: 'sessions#plus'

  match '/signout', to: 'sessions#destroy', via: :delete

  match 'auth/:provider/callback', to: 'sessions#check_external'

  scope(:path_names => { :new => "nouveau", :edit => "edition" }) do

    resources :galleries, only: [:index, :show], path: '/medias'
    resources :events, only: [:index, :show], path: '/programme'
    resources :users, only: [:update, :create]
    
    resources :articles, only: [:show] do 
      member { get :likes }
      resources :comments, only: [:create] do
        collection { get :individual_feed }
      end
    end
    resources :comments, except: [:create, :new] do
      member do
        get 'up'
        get 'down'
      end
    end

  	namespace :admin do

  		resources :users, except: [:show, :new, :create]

  		resources :pages do 
        member { post :mercury_update }
      end
  		resources :events, except: [:show]
  		resources :articles, except: [:show] do 
        member { post :mercury_update }
      end
  		resources :galleries, except: [:show] do 
  			resources :paintings, except: [:index, :show]
  		end
  		resources :images, except: [:show]
  		resources :slideshows, except: [:show]
  		resources :mercury_images, only: [:index, :create, :destroy]
      resources :categories, except: [:show]
      resources :ownerships, except: [:show]

  	end

    scope "admin/group", as: "admin_group" do
      scope :module => "group" do
        scope :module => "admin" do

          resources :groups, except: [:show]
          resources :cantons, except: [:show]

        end
      end
    end

  	resources :sessions, only: [:create, :destroy]

  end
end
