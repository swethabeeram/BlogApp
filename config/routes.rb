Blogapplication::Application.routes.draw do

  root :to => "posts#index"
  
  get "/feeds/posts", :controller => "feeds", :action => "posts", :format => "atom"

  get "/feeds/posts/:id", :controller => "feeds", :action => "comments", :format => "atom"

  resources :shops

  resources :posts do
    resources :comments
    collection do
      get "haml_demo"
    end
  end

  resources :categories

  resources :photos do
    member do
      get 'download'
    end
  end

  resources :attachments do
    member do
      get 'download'
    end
  end


  resources :users  do
    collection do
      get 'login'
      post 'login'
      post 'signup'

      get "logout"
    end

    member do
    end
  end
end
