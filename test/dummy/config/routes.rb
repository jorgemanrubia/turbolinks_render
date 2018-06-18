Rails.application.routes.draw do
  resources :tasks do
    collection do
      put :update_with_turbolinks
      post :update_with_turbolinks
      put :update_without_turbolinks
      post :update_without_turbolinks
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
