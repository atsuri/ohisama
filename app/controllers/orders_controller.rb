class OrdersController < ApplicationController
    before_action :login_required

    def index
        new_cart
        @order = Order.all
    end
    
    def new
        @order = Order.new()
    end

    def create
        order = Order.find_by(member_id: current_member.id, status: 1)
        @order = Order.find(order.id)
        @item = Item.find_by(id: params[:order][:item_id].to_i)
        @orderitem = OrderItem.find_by(order_id: @order.id, item_id: params[:order][:item_id].to_i, orderitem_regular: false)

        if @orderitem.present? #既にカートにあったら
                
            item_quantity = Item.find_by(id: params[:order][:item_id].to_i).item_quantity-params[:order][:order_quantity].to_i
            if item_quantity >= 1
                @orderitem.orderitem_quantity = @orderitem.orderitem_quantity+params[:order][:order_quantity].to_i
                if item_quantity == 1
                    @item.disable = true
                end

                if @orderitem.save
                    @orderitem = OrderItem.find_by(order_id: order.id, item_id: params[:order][:item_id].to_i, orderitem_regular: false)
                    @orderitem.orderitem_price = Item.find_by(id: params[:order][:item_id].to_i).price
                    if @orderitem.save
                        @item.item_quantity = Item.find_by(id: params[:order][:item_id].to_i).item_quantity-params[:order][:order_quantity].to_i
                        if @item.save
                            redirect_to :categories, notice: "既にカートにあるため、個数を編集しました。"
                        else
                            puts "saveできませんでした.."
                        end
                    else
                        render "new"
                    end
                else
                    render "new"
                end
            else
                orderable = params[:order][:order_quantity].to_i + item_quantity-1
                @orderitem.orderitem_quantity = @orderitem.orderitem_quantity + orderable

                if @orderitem.save
                    @orderitem = OrderItem.find_by(order_id: order.id, item_id: params[:order][:item_id].to_i, orderitem_regular: false)
                    @orderitem.orderitem_price = @item.price
                    if @orderitem.save
                        @item.item_quantity = @item.item_quantity-orderable
                        
                        @item.disable = true
                        if @item.save
                            redirect_to :categories, notice: "申し訳ありません。在庫が足りなかったため、#{orderable}個カートに入れました。
                                既にカートにあるため、個数を編集しました。"
                        else
                            puts "#{orderable}saveできませんでした.."
                        end
                    else
                        render "new"
                    end
                else
                    render "new"
                end
            end
        else # カートに入ってない商品
            @order.items << @item
            @orderitem = OrderItem.find_by(order_id: order.id, item_id: params[:order][:item_id].to_i, orderitem_regular: false)  
            @orderitem.orderitem_price = Item.find_by(id: params[:order][:item_id].to_i).price
            @orderitem.save #値段保存      
            @orderitem = OrderItem.find_by(order_id: order.id, item_id: params[:order][:item_id].to_i, orderitem_regular: false)
            @orderitem.orderitem_name = Item.find_by(id: params[:order][:item_id].to_i).item_name
            @orderitem.save #商品名保存 

            # 在庫数、注文数の保存
            @orderitem = OrderItem.find_by(order_id: order.id, item_id: params[:order][:item_id].to_i, orderitem_regular: false)
            item_quantity = Item.find_by(id: params[:order][:item_id].to_i).item_quantity-params[:order][:order_quantity].to_i
            if item_quantity >= 1
                @orderitem.orderitem_quantity = params[:order][:order_quantity].to_i
                if item_quantity == 1
                    @item.disable = true
                end
                @orderitem.save #注文個数保存

                @item.item_quantity = Item.find_by(id: params[:order][:item_id].to_i).item_quantity-params[:order][:order_quantity].to_i
                if @item.save #在庫数保存 (残り１なら欠品カラムも保存)
                    redirect_to :categories, notice: "カートに入れました。"
                else
                    puts "#{params[:order][:order_quantity].to_i}saveできませんでした.."
                    render "new"
                end
            else
                orderable = params[:order][:order_quantity].to_i + item_quantity-1
                @orderitem.orderitem_quantity = orderable
                @orderitem.save #注文個数保存
                
                @item.item_quantity = Item.find_by(id: params[:order][:item_id].to_i).item_quantity-orderable
                @item.disable = true
                if @item.save
                    @orderitem.orderitem_quantity = orderable
                    redirect_to :categories, notice: "申し訳ありません。在庫が足りなかったため、#{orderable}個カートに入れました。"
                else
                    puts "#{orderable}saveできませんでした.."
                    render "new"
                end
            end
        end
    end

    # カート内編集はなし（ ;  ; ）
    # def edit
    #     @order = Order.find(params[:id])
    # end

    # def update
    #     @order = Order.find(params[:id])
    #     memberid = Order.where(member_id: current_member.id)
    #     orderid = memberid.find_by(status: 1)
    #     @orderitem = OrderItem.find_by(order_id: orderid.id, item_id: params[:order][:item_id])
    #     @orderitem.orderitem_quantity = params[:order][:order_quantity].to_i
    #     if @orderitem.save
    #         redirect_to orders_path(cart: "cart"), notice: "カートを編集しました"
    #     else
    #         render "edit"
    #     end
    # end

    def destroy
        order = Order.find_by(status: 1, member_id: current_member.id)
        # @order = Order.find(order.id)
        # @item = Item.find(params[:item_id].to_i.id)
        @item = OrderItem.find_by(order_id: order.id, item_id: params[:item_id].to_i, orderitem_regular: false)
        # @item = Item.find(@item.id)
        
        item = Item.find_by(id: params[:item_id])
        orderitem = OrderItem.find_by(order_id: order.id, item_id: item.id, orderitem_regular: false)
        item_quantity = item.item_quantity
        orderitem_quantity = orderitem.orderitem_quantity
        item.item_quantity = item.item_quantity + orderitem.orderitem_quantity
    
        if orderitem.destroy
            if  item_quantity-1 + orderitem_quantity >0
                item.disable = false
            end

            if item.save
                if  OrderItem.where(order_id: order.id).present? == false
                    order.destroy
                end
                redirect_to orders_path(cart: "cart"), notice: "注文商品を取り消しました。"
            else
                puts "できなかった"
            end
        else
            redirect_to orders_path(cart: "cart"), notice: "注文商品を取り消せませんでした。"
        end
    end
  
end
