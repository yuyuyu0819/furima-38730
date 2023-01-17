class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]

  def index
    @address_form = AddressForm.new
  end

  def create
    
    @address_form = AddressForm.new(address_params)
    if @address_form.valid?
      pay_item
      @address_form.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def address_params
    params.require(:address_form).permit(:zip_code, :prefecture_id, :city, :block_number, :apartment_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,   # 商品の値段
      card: purchase_params[:token],   # カードトークン
      currency: 'jpy'    # 通貨の種類（日本円）
    )
  end

end
