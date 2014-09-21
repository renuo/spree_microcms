SpreeMicrocms::Engine.routes.draw do
  namespace :admin do
    resources :pages do
      collection do
        post :update_positions
      end
    end
  end
  resources :pages

  get '/:slug', to: 'pages#show_slug', slug: /.*/, as: :cms_slug
end
