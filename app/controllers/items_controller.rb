class ItemsController < ApplicationController
  before_action :authenticate_user!, only: :new
  before_action :move_to_index, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.includes(:user).order('created_at DESC')
    @orders = Order.includes(:user, :item)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.valid?
      @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @orders = Order.includes(:user, :item)
  end

  def edit
  end

  def update
    if @item.valid?
      @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  private

  def item_params
    params.require(:item)
          .permit(:image, :item_name, :text, :category_id, :product_status_id,
                  :shipping_fee_status_id, :prefecture_id, :scheduled_delivery_id, :price)
          .merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  def set_item
    @item = Item.find(params[:id])
  end
end

