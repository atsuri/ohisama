class RegularsController < ApplicationController
    before_action :login_required

    def index
        if current_member
            @member = current_member
            @regular = Regular.where(member_id: @member.id)
        else
            @member = Member.find(params[:id])
            @regular = Regular.where(member_id: @member.id)
        end
    end

    #検索
    def search
        @members = Member.search(params[:q])
        @members = Regular.where(member_id: @members.ids)
        if params[:milk].present? || params[:eggs].present?
            @members = Regular.find(@member.id)
            @members = @members.where(item_id: [params[:milk], params[:eggs]])
                # .page(params[:page]).per(15) 
        end

        render "index"
    end

    def edit
        @regular = Regular.find(params[:id])
    end

    #更新
    def update
        @regular = Regular.find(params[:id])
        @regular.regular_quantity = params[:regular_quantity]

        if @regular.save
            order = Order.find_by(member_id: current_member.id, status: 1)
            @order = Order.find(order.id)

            regular_milk = Regular.find_by(item_id: 9, member_id: current_member.id)
            regular_eggs = Regular.find_by(item_id: 10, member_id: current_member.id)

            @orderitem = OrderItem.find_by(order_id: order.id, item_id: 9)
            @orderitem.orderitem_quantity = regular_milk.regular_quantity
            @orderitem.save

            @orderitem = OrderItem.find_by(order_id: order.id, item_id: 10)
            @orderitem.orderitem_quantity = regular_eggs.regular_quantity
            @orderitem.save

            redirect_to :account, notice: "定期便情報を更新しました。"
        else
            render "edit"
        end
    end
end
