Rails.application.routes.draw do
  resources :tasks do
    collection do
      %i[put post patch].each do |verb|
        send verb, :update_with_turbolinks
        send verb, :update_with_turbolinks_forcing_it
        send verb, :update_without_turbolinks
        send verb, :update_with_json_response
        send verb, :update_ignored
        send verb, 'update_ignored/subpath', action: 'update_ignored_subpath'
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
