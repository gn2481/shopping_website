class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  helper_method :current_cart

  def current_cart
    @current_cart ||= find_cart
  end

  def require_is_admin
    if !current_user.admin?
      redirect_to root_path, notice: '你不是管理者喔'
    end
  end

  private
  def find_cart
    cart = Cart.find_by(id: session[:cart_id])
    if cart.blank?
      cart = Cart.create
    end
    session[:cart_id] = cart.id
    return cart
  end

end
