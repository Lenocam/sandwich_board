Rails.application.routes.draw do
	root 'static_pages#home'
	get 'signup' => 'users#new'

	get    'login'  => 'sessions#new'
	post   'login'  => 'sessions#create'
	delete 'logout' => 'sessions#destroy'

	resources :users, shallow: true do
		resources :galleries
		resources :images
		resources :categories
	end

	resources :account_activations, only: [:edit]
	resources :password_resets,     only: [:new, :create, :edit, :update]

	#Api

	namespace :api, defaults: {format: 'json'} do
		namespace :v1  do
			resources :users, only: [:index, :create, :show, :update, :destroy], shallow: true do
				resources :galleries
				resources :categories
				resources :images
		end
		end
	end
end
