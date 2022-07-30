class Admin::OrdersController < Admin::Base

    def index
        @order = Order.all
        @member = Member.all
    end

    def edit
        @order = Order.find(params[:id])
        @member = Member.find(params[:member_id])
    end

    def update
        @member = Member.find(params[:member_id])
        @order = Order.find(params[:id])
        status = params[:order][:status].to_i

        if status == 2
            Member.where(group: @member.group).each do |member| #同じグルの人みんな変更
                @order = Order.find_by(status: 1, member_id: member.id)
                if member.regular_member
                    order = OrderItem.where(order_id: @order.id)
                else
                    regularitem = OrderItem.where(order_id: @order.id, orderitem_regular: true)
                    if regularitem.present?
                        regularitem = OrderItem.find_by(order_id: @order.id, item_id: 9, orderitem_regular: true)
                        regularitem.destroy#milk
                        regularitem = OrderItem.find_by(order_id: @order.id, item_id: 10, orderitem_regular: true)
                        regularitem.destroy#egg
                    end
                end

                @order = Order.find_by(status: 1, member_id: member.id)
                # orderitem = OrderItem.where(order_id: @order.id)
                if @order.present?
                    @order.status = status

                    if @order.save
                        # カート作成
                        @order = Order.new()
                        @order.member_id = member.id
                        @order.status = 1
                        if @order.save
                            #Regular入れる
                            regular_milk = Regular.find_by(item_id: 9, member_id: member.id)
                            regular_eggs = Regular.find_by(item_id: 10, member_id: member.id)

                            order = Order.find_by(member_id: member.id, status: 1)
                            @order = Order.find(order.id)
                            @item = Item.find(9) #milk
                            @order.items << @item

                            @orderitem = OrderItem.find_by(order_id: @order.id, item_id: 9)
                            @orderitem.orderitem_regular = true
                            @orderitem.save
                            @orderitem = OrderItem.find_by(order_id: @order.id, item_id: 9)
                            @orderitem.orderitem_quantity = regular_milk.regular_quantity
                            @orderitem.save
                            @orderitem = OrderItem.find_by(order_id: @order.id, item_id: 9)
                            @orderitem.orderitem_price = @item.price
                            @orderitem.save
                            @orderitem = OrderItem.find_by(order_id: @order.id, item_id: 9)
                            @orderitem.orderitem_name = Item.find(9).item_name
                            @orderitem.save

                            @item = Item.find(10) #egg
                            @order.items << @item
                            @orderitem = OrderItem.find_by(order_id: @order.id, item_id: 10)
                            @orderitem.orderitem_regular = true
                            @orderitem.save
                            @orderitem = OrderItem.find_by(order_id: @order.id, item_id: 10)
                            @orderitem.orderitem_quantity = regular_eggs.regular_quantity
                            @orderitem.save
                            @orderitem = OrderItem.find_by(order_id: @order.id, item_id: 10)
                            @orderitem.orderitem_price = @item.price
                            @orderitem.save
                            @orderitem = OrderItem.find_by(order_id: @order.id, item_id: 10)
                            @orderitem.orderitem_name = Item.find(10).item_name
                            @orderitem.save
                        else
                            puts "カート作成できなかった"
                        end
                    end
                end
            end
        elsif status == 3
            Member.where(group: @member.group).each do |member| #同じグルの人みんな変更
                @order = Order.find_by(status: 2, member_id: member.id)
                if @order.present?
                    @order.status = 3
                    @order.save
                end
            end

        elsif status == 4
            Member.where(group: @member.group).each do |member| #同じグルの人みんな変更
                @order = Order.find_by(status: 3, member_id: member.id)
                if @order.present?
                    @order.status = 4
                    @order.save
                end
            end
        end
        redirect_to admin_orders_path(), notice: "statusを更新しました。"
    end
end