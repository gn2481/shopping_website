class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_is_admin
  before_action :find_product, only: [:edit, :update, :show, :destory]
  layout 'admin'

  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new
  end
  
  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path, notice: "商品成功新增！"
    else
      render :new
      redirect_to root_path, notice: "請再試一次！"
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to root_path, notice: "商品編輯成功！"
    else
      render :edit, notice: "請再試一次！"
    end
  end

  def destroy
  end  

  private 
  def find_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :quantity, :image)
  end
end
