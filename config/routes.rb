Rails.application.routes.draw do
  # 管理者側のルーティング設定
  namespace :admin do
    root to: 'homes#top'
    resources :services,only: [:index, :new, :create, :show, :edit, :update]
    resources :customers,only: [:index, :edit, :show, :update]
    resources :requests,only: [:show, :update]
    resources :request_details,only: [:update]
    resources :questions,only: [:index, :edit, :show, :update]
  end

  # 顧客側のルーティング設定
  scope module: :public do
    root to: "homes#top"
    get 'homes/about' => 'homes#about', as: 'about'
    resources :services,only: [:index, :show]
    resources :request_lists, only: [:index, :create, :destroy, :update] do
      collection do
        delete 'destroy_all'
      end
    end
    get 'customers/my_page' => 'customers#show'
    get 'customers/my_page/edit' => 'customers#edit'
    patch 'customers/my_page' => 'customers#update'
    get 'customers/my_page/confirm_withdraw' => 'customers#confirm_withdraw'
    patch 'customers/my_page/withdraw' => 'customers#withdraw'
    resources :requests,only: [:index, :create, :new, :show, :update] do
      collection do
        post 'confirm'
        get 'thanx'
      end
    end
    resources :questions,only: [:create, :new, :index, :show] do
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
  #ゲストログイン
  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
