Rails.application.routes.draw do
  root 'products#index'
  
  devise_for :users
  
  namespace :admin do
    resources :products
    resources :orders do
      member do
        post :cancel  # 取消訂單
        post :ship    # 出貨
        post :shipped # 到貨
        post :return  # 退貨

      end
    end
  end

  namespace :account do
    resources :orders
  end

  resources :products do
    member do
      post :add_to_cart
    end
  end

  resources :carts do
    collection do
      delete :clean
      post :checkout
    end
  end

  resources :cart_items
  
  resources :orders do
    member do
      post :pay_with_credit_card
      post :pay_with_atm
      post :apply_to_cancel
    end
  end
end
