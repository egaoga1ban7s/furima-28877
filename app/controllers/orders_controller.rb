class OrdersController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :move_to_root, only: :index
  def index
    @order = OrderAddress.new
    @item = Item.find(params[:item_id])
  end

  def create
    binding.pry
    @order = OrderAddress.new(order_params)
    binding.pry
    @item = Item.find(params[:item_id])
    if @order.valid?
      @order.save
      pay_item
      redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :telephone)
          .merge(user_id: current_user.id, token: params[:token], item_id: params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    amount = @item.price
    Payjp::Charge.create(
      amount: amount,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_root
    @orders = Order.includes(:user, :item)
    @user = Item.find(params[:item_id]).user_id
    redirect_to root_path if @user == current_user.id || @orders.where(item_id: params[:item_id]).present?
  end
end
