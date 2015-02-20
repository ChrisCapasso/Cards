Rails.application.routes.draw do
  
devise_for :users
root 'home#index'
resources :projects do
resources :cards, shallow: true, only: [:create, :destroy, :update] do
	collection {post :sort}
	end
  end

end
