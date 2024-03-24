Rails.application.routes.draw do
  root 'static_pages#top'

  # ログイン/ログアウト関連のルーティング
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  # 会員登録のルーティング
  resources :users, only: [:new, :create]

  # 投稿関係のルーティング
  resources :boards do
    collection do
      get 'bookmarks'
    end
  end

  # お気に入り投稿のルーティング
  resources :bookmarks, only: %i[create destroy]
end
