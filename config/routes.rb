DictyConf2::Application.routes.draw do

	root to: 'home#index', :as => :home

	resource :user_sessions, only: [:create, :new, :destroy]
	resource :users, only: [:create, :new, :edit, :update, :show] 
	resource :abstracts, only: [:new, :create, :edit]
	resource :registrations

	match 'login' => 'user_sessions#new', :as => :login
	match 'logout' => 'user_sessions#destroy', :as => :logout
	match 'signup' => 'users#new', :as => :signup
	match 'profile' => 'users#show', :as => :profile

	match 'registration' => 'registrations#index', :as => :registration
	match 'abstracts' => 'abstracts#index', :as => :abstracts

	match '/travel' => 'home#travel', :as => :travel
	match '/sponsors' => 'home#sponsors'

end
