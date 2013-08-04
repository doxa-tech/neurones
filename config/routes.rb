Neurones::Application.routes.draw do

  mount Mercury::Engine => '/'

  root to: 'pages#home', format: 'html'
  match '/blog', to: 'articles#index'
  match '/home', to: 'pages#home'
  match '/presentation', to: 'pages#presentation'
  match '/contact', to: 'pages#contact'
  match '/catalogue', to: 'group::group_groups#index'

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

  	namespace :admin do

  		resources :users, except: [:show] 

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
      
      resources :ownerships, except: [:show] do
        collection do
          get 'ownerships'
          get 'parents'
        end
      end

      resources :parents, except: [:show]

  	end
    
    namespace :group do
      namespace :admin do
        resources :group_groups, except: [:show], path: "groups" do
          member do
            get "activation"
            put "activate"
          end
          
          resources :group_pages, except: [:show], path: "pages" do
            resources :group_comp_pages, only: [:new, :destroy], path: "comp_pages" do
              member do
                get 'up'
                get 'down'
              end
            end
          end
          resources :group_modules, only: [:index], path: "modules" do
            member do
              get "activate"
              get "desactivate"
            end
          end
        end
        
        resources :group_cantons, except: [:show], path: "cantons"
      end
    end

  	resources :sessions, only: [:create, :destroy]

  end
  
  # group paths
  
  match '/:group_group_id', to: 'group::group_pages#show'
  
  scope module: :group do
    resources :group_groups, path: "" do
      resources :group_pages, only: [:show], path: ""
    end
  end

end
