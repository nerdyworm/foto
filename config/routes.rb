Foto::Application.routes.draw do


  devise_for :users
  
  get "welcome/index"
  get "profile"       => "profiles#user_profile", :as => :user_profile
  get "profile/edit"  => "profiles#edit",         :as => :edit_user_profile
  post"profile/edit"  => "profiles#update"
  get "profiles/:id"  => "profiles#show"
  put "profile"       => "profiles#update"
  
  get "/users/:username" => "profiles#show",       :as => :username_profile
  resources :users do
    resources :pictures
    resources :feedbacks
  end
  
  resources :pictures do
    resources :feedbacks
  end

  match "/pictures/tags/:tag" => "pictures#tags", :as => :tag
  match "/feedbacks/"               => "feedbacks#index"
  match "/feedbacks/:id/upvote"     => "feedbacks#upvote", :as => :feedback_upvote
  match "/feedbacks/:id/downvote"   => "feedbacks#downvote", :as => :feedback_downvote

  root :to => "welcome#index"
end
