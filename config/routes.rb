require 'api_constraints'

Neurones::Application.routes.draw do

  use_doorkeeper

  root to: 'pages#home', format: 'html'
  match '/blog', to: 'articles#index'
  match '/home', to: 'pages#home'
  match '/presentation', to: 'pages#presentation'
  match '/contact', to: 'pages#contact'
  match '/catalogue', to: 'groups#index'

  match '/profil', to: 'users#profile'
  match '/inscription', to: 'users#new'

  match '/login', to: 'sessions#login'
  match '/login-plus', to: 'sessions#plus'

  match '/signout', to: 'sessions#destroy', via: :delete

  match 'auth/:provider/callback', to: 'sessions#check_external'
  
  scope(:path_names => { :new => "nouveau", :edit => "edition" }) do

    resources :galleries, only: [:index, :show], path: '/medias'
    resources :events, only: [:index, :show], path: '/evenements'
    resources :users, only: [:update, :edit, :create, :show]
    
    resources :articles, only: [:show] do 
      member do
        get 'vote'
      end

      resources :comments, except: [:index, :show] do

        member do
          get 'new_subcomment'
          get 'up'
          get 'down'
          get 'subcomments_feed'
          get 'more_subcomments'
        end

        collection do
          get 'article_comments_feed'
        end
      end
      
    end
    resources :comments, only: [:index]
    
    resources :sessions, only: [:create, :destroy]

  	namespace :admin do

  		resources :users, except: [:show] 

  		resources :pages, except: [:show, :new]
  		resources :events, except: [:show]
  		resources :articles, except: [:show]
  		resources :galleries, except: [:show] do 
  			resources :paintings, only: [:new, :create, :destroy]
  		end
  		resources :images, except: [:show]
  		resources :slideshows, except: [:show]
      resources :categories, except: [:show]
      
      resources :ownerships, except: [:show] do
        collection do
          get 'ownerships'
          get 'parents'
        end
      end
      
      resources :cantons, except: [:show]
      resources :parents, except: [:show]
      resources :modules, except: [:show], as: :g_modules
      resources :styles, except: [:show], as: :g_styles

      #admin group

      resources :groups, except: [:show] do
        member do
          get "activation"
          put "activate"
        end

        namespace :g, path: "" do
             
          resources :pages, except: [:show] do
            member do
              get 'up'
              get 'down'
            end

            resources :comp_pages, only: [:new, :destroy] do
              member do
                get 'up'
                get 'down'
              end
            end
          end

          resources :texts, only: [:update]
          
          resources :modules, only: [:index] do
            member do
              get "activate"
              get "desactivate"
            end
          end

          resources :events, except: [:show]
          resources :news, except: [:show]
          resources :galleries, except: [:show] do 
            resources :paintings, only: [:new, :create, :destroy]
          end
          resources :images, except: [:show]

          resources :styles, except: [:show] do
            member do 
              put 'update_stylesheet'
            end
            collection do
              get 'themes'
              post 'update_theme'
            end
          end
        end

      end
  	end
  end

  # group paths
  
  match '/:group_id', to: 'g::pages#show'
  
  resources :groups, only: [], path: "" do
    scope module: :g do
      resources :pages, only: [:show], path: ""
      resources :galleries, only: [:show]
      resources :news, only: [:show]
      resources :events, only: [:show]
      resources :styles, only: [:show]
    end
  end

  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      scope module: :groups do
        resources :groups do
          resources :galleries
          resources :news
          resources :events
        end
      end
    end
  end

end
