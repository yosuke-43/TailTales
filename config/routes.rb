Rails.application.routes.draw do
  root 'static_pages#top'
  get 'terms', to: 'static_pages#terms_of_service'
  get 'privacy_policy', to: 'static_pages#privacy_policy'

  # ログイン/ログアウト関連のルーティング
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  # 会員登録のルーティング
  resources :users, only: [:new, :create]

  # 投稿関係のルーティング
  resources :boards do
    resources :comments, only: %i[create destroy], shallow: true
    collection do
      get 'bookmarks'
    end
  end

  # Dog関連のルーティング
  namespace :dogs do
    resources :lists, only: :index, defaults: { format: :json}
  end

  resources :dogs, only: [:show, :index]

  # お気に入り投稿のルーティング
  resources :bookmarks, only: %i[create destroy]

  #診断関係のルーティング
  resources :diagnoses, only: [:new, :create]
  get 'diagnoses_result', to: 'diagnoses#result'
end
