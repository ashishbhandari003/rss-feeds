Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :feeds do
	  member do
	   resources :posts
	  end
	end

	get '/fetch_feeds', controller: 'posts', action: 'fetch_feeds', as: 'fetch_feeds'
	
	root 'posts#index'
end
