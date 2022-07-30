class Admin::ItemsController < Admin::Base
    before_action :admin_login_required

    def index
        @items = Item.all
    end

    def search #デイリー食品 生鮮 加工食品 飲料・菓子・アイス 冷凍食品 お米・お酒 日用品 化粧品
        @items = Item.search(params[:q])
        render "index"
    end

    def show
        @item = Item.find(params[:id])
        @order = Order.new()
    end

    def new
        @item = Item.new()
    end

    def create
        @item = Item.new()
        @category = Category.find(params[:category_id])
        @item.category_id = @category.id
        @item.item_name = params[:item_name]
        @update1 = params[:item_name]
        @item.price = params[:price].to_i
        @item.item_quantity = params[:item_quantity].to_i #在庫数が1以上だから
        @item.disable = params[:disable].to_i

        if @item.save
            @item = Item.find_by(item_name: @update1, category_id: @category.id)
            @item.item_quantity = @item.item_quantity+1#調整
            if @item.save
                redirect_to :admin_categories, notice: "商品を登録しました。"
            else
                render "new"
            end
        else
            render "new"
        end
    end

    def edit
        @category = Category.find(params[:category_id])
        @item = Item.find(params[:id])
    end

    #更新
    def update
        @category = Category.find(params[:category_id])
        @item = Item.find(params[:id])
        @item.category_id = @category.id
        @item.item_name = params[:item_name]
        @item.price = params[:price].to_i
        @item.item_quantity = params[:item_quantity].to_i
        @item.disable = params[:disable].to_i
        # @item.assign_attributes(item_params)
        # @item.assign_attributes(params[:item])
        if @item.save
            @item.item_quantity = @item.item_quantity+1#調整
            if @item.save
                redirect_to :admin_categories, notice: "商品情報を更新しました。"
            else
                render "edit"
            end
        else
            render "edit"
        end
    end

    #削除
    def destroy
        @item = Item.find(params[:id])
        @item.destroy
        redirect_to :admin_categories, notice: "商品を削除しました。"
    end

    # ここどこにも使ってない
    private def item_params
        attrs = [
            :category_id,
            :item_name,
            :price,
            :item_quantity,
            :disable
        ]
        params.require(:item).permit(attrs)

    end

end
