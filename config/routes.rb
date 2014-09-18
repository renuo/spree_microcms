SpreeMicrocms::Engine.routes.draw do

  namespace :micro_cms do
    resources :pages

    namespace :admin do
      resources :pages do
        collection do
          post :update_positions
        end
      end
    end
  end
  match 'p/(:slug)', to: 'micro_cms/pages#show_slug', slug: /.*/, via: [:get], as: :cms_slug
end
