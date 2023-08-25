Rails.application.routes.draw do
  # 管理者側のルーティング設定
  namespace :admin do
    root to: 'homes#top'
    resources :services,only: [:index, :create, :new, :edit, :show, :update]
    resources :customers,only: [:index, :edit, :show, :update]
    resources :requests,only: [:show, :update]
    resources :request_detail,only: [:update]
    resources :questions,only: [:index, :edit, :show, :update]
  end

  # 顧客側のルーティング設定
  scope module: :public do
    root to: "homes#top"
    get 'homes/about' => 'homes#about', as: 'about'
    resources :services,only: [:index, :show]
    get 'customers/my_page' => 'customers#show'
    get 'customers/my_page/edit' => 'customers#edit'
    patch 'customers/my_page' => 'customers#update'
    get 'customers/my_page/confirm_withdraw' => 'customers#confirm_withdraw'
    patch 'customers/my_page/withdraw' => 'customers#withdraw'
    resources :requests,only: [:index, :create, :new, :show] do
      collection do
        post 'confirm'
        get 'thanx'
      end
    end
    resources :questions,only: [:create, :new] do
      collection do
        post 'confirm'
        get 'thanx'
      end
    end
  end

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
