class Admin::CategoriesController < Admin::Base
    before_action :admin_login_required

    def index
        @categories = Category.all
    end

    def search #デイリー食品 生鮮 加工食品 飲料・菓子・アイス 冷凍食品 お米・お酒 日用品 化粧品
        # @category = Category.find(params[:id])
        # @items = Item.search(params[:q])


        @items = Item.search(params[:q])
        if params[:fruits].present? || params[:vegetables].present? || 
            params[:fish].present? || params[:meats].present? || params[:drinks].present? ||
            params[:bread].present? || params[:spices].present? || params[:dairy].present?

            @items = @items.where(category_id: [params[:fruits], params[:vegetables], params[:fish], 
                params[:meats], params[:drinks], params[:bread], params[:spices], params[:dairy]])
                # .page(params[:page]).per(15) 
        end
        
        render "show"
    end
end
