class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:edit, :show, :update, :destroy]
  before_action :move_to_index, only: [:edit, :destroy]
  before_action :purchase_check, only: [:edit]
  
  
  def index
    @items = Item.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    
  end
  
  def edit
    
  end

  def update
    
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end
  
  def destroy
    if @item.destroy
       redirect_to root_path
    end
end

 private
  def item_params
    params.require(:item).permit(:image, :title, :description, :status_id, :delivery_charge_id, :prefecture_id, :delivery_date_id, :category_id, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
  unless @item.user.id == current_user.id 
    redirect_to root_path
  end
 end
 def purchase_check
  if @item.purchase.present?
    redirect_to root_path
 end 
end
end
