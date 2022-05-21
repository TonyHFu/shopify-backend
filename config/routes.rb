Rails.application.routes.draw do
	root to: 'products#index'

	resources :products

	resources :orders, only: %i[index show create]

	resource :cart, only: [:show] do
		post :add_item
		post :remove_item
	end

	# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

	# Defines the root path route ("/")
	# root "articles#index"
end
