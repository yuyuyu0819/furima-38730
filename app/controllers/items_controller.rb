class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
  end

  def new
  end

 private
  def item_params
    params.require(:item).permit(:image, :item_title, :item_description, :item_status_id. :item_delivery_charge_id, :prefecture_id, :delivery_date_id, :category_id, :price).merge(user_id: current_user.id)
  end
 
end
