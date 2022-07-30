class ItemsController < ApplicationController
    def index
        @items = Item.all
    end

    def search #デイリー食品 生鮮 加工食品 飲料・菓子・アイス 冷凍食品 お米・お酒 日用品 化粧品  
        @items = Item.search(params[:q])
        @items = @items.where(category_id: params[:category_id])
        render "index"
    end

    def show
        @item = Item.find(params[:id])
        @order = Order.new()
    end
end
