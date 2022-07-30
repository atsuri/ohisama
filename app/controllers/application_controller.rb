class ApplicationController < ActionController::Base
    before_action :update_expiration_time

    private def regular_new #アカウント作成時に書く
        @regular = Regular.new()
        @regular.item_id = Item.find(9).id #milk
        @regular.member_id = Member.find(cookies[:member_id].to_i).id
        @regular.regular_quantity = 1 #defalut=1
        @regular.update_at = "#{rand(1980..2000)}-12-01"

        if @regular.save
            puts "milk入れられた！！"
        else
            puts "milk入れるのできなかった"
        end

        @regular = Regular.new()
        @regular.item_id = Item.find(10).id #egg
        @regular.member_id = Member.find(cookies[:member_id].to_i).id
        @regular.regular_quantity = 1 #defalut=1
        @regular.update_at = "#{rand(1980..2000)}-12-01"

        if @regular.save
            puts "egg入れられた！！"
            new_cart #カート作成
        else
            puts "egg入れるのできなかった"
        end
    end
    helper_method :regular_new

    private def input_regular #カートが作成時に書く
        regular_milk = Regular.find_by(item_id: 9, member_id: cookies[:member_id].to_i)
        regular_eggs = Regular.find_by(item_id: 10, member_id: cookies[:member_id].to_i)

        order = Order.find_by(member_id: cookies[:member_id].to_i, status: 1)
        @order = Order.find(order.id)

        @item = Item.find(9) #milk
        @order.items << @item
        @orderitem = OrderItem.find_by(order_id: order.id, item_id: 9)
        @orderitem.orderitem_regular = true
        @orderitem.save
        @orderitem = OrderItem.find_by(order_id: order.id, item_id: 9)
        @orderitem.orderitem_quantity = regular_milk.regular_quantity
        @orderitem.save
        @orderitem = OrderItem.find_by(order_id: order.id, item_id: 9)
        @orderitem.orderitem_price = Item.find(9).price
        @orderitem.save
        @orderitem = OrderItem.find_by(order_id: @order.id, item_id: 9)
        @orderitem.orderitem_name = Item.find(9).item_name
        @orderitem.save

        @item = Item.find(10) #egg
        @order.items << @item
        @orderitem = OrderItem.find_by(order_id: order.id, item_id: 10)
        @orderitem.orderitem_regular = true
        @orderitem.save
        @orderitem = OrderItem.find_by(order_id: order.id, item_id: 10)
        @orderitem.orderitem_quantity = regular_eggs.regular_quantity
        @orderitem.save
        @orderitem = OrderItem.find_by(order_id: order.id, item_id: 10)
        @orderitem.orderitem_price = Item.find(10).price
        @orderitem.save
        @orderitem = OrderItem.find_by(order_id: @order.id, item_id: 10)
        @orderitem.orderitem_name = Item.find(10).item_name
        @orderitem.save
    end
    helper_method :input_regular

    private def new_cart #status変更時
        if Order.find_by(member_id: cookies[:member_id].to_i, status: 1).present?
        else
            @order = Order.new()
            @order.member_id = cookies[:member_id].to_i
            @order.status = 1
            if @order.save
                input_regular #Regular入れる
            else
                puts "カート作成できなかった"
            end 
        end
    end
    helper_method :new_cart

    private def item_check
        Item.all.each do |item|
            sum = 0
            orderitem = OrderItem.where(item_id: item.id)
            orderitem.each do |quantity|
                quantity = quantity.orderitem_quantity
                sum = sum + quantity
            end     
            if item.item_quantity - sum == 0
                item.disable == true
                if item.save
                    puts "ほぞん！！！！！！"
                end
            end
        end
    end
    helper_method :item_check

    private def day_check
        require "date"
        require "time"
        today = Date.today
        # puts "日付表示#{today}"
        day = today.wday # 作成したDateオブジェクトから曜日を数字として取得
        # days = ["日曜日", "月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日"]
        # puts "今日は#{days[day]}です"
        # t = Time.now
        # puts "今は#{t.hour+9}:#{t.min}:#{t.sec}です"
        
        if current_member
            memberid = Order.where(member_id: current_member.id)
            orderid = memberid.find_by(status: 1)

            if orderid.present?
                group = Member.find(current_member.id).group
                if day-1 == group-1 #1,3,5
                    t = Time.now
                    if t.hour+9 >= 20 && t.min >= 27 && t.sec >= 00
                        orderid.status = 2
                    end
                end
            end
        end
    end


    
    private def current_member
        Member.find_by(id: cookies[:member_id]) if cookies[:member_id]
        # Member.find_by(id: cookies.signed[:member_id]) if cookies[:member_id]
    end
    helper_method :current_member

    private def current_admin
        Administrator.find(1) if cookies[:id]
    end
    helper_method :current_admin

    private def update_expiration_time
        if cookies[:member_id]
            member = Member.find_by(id: cookies[:member_id])
            cookies[:member_id] = { value: member.id, expires: 5.minutes.from_now }
        end
    end

    private def update_expiration_time_admin
        if cookies[:id]
            member = Member.find_by(id: cookies[:id])
            cookies[:id] = { value: member.id, expires: 5.minutes.from_now }
        end
    end

    class LoginRequired < StandardError; end
    class Forbidden < StandardError; end

    private def login_required
        raise LoginRequired unless current_member
    end

    private def admin_login_required
        raise LoginRequired unless current_admin
    end

    if Rails.env.production? || ENV["RESCUE_EXCEPTIONS"]
        rescue_from StandardError, with: :rescue_internal_server_error
        rescue_from ActiveRecord::RecordNotFound, with: :rescue_not_found
        rescue_from ActionController::ParameterMissing, with: :rescue_bad_request
    end

    rescue_from LoginRequired, with: :rescue_login_required
    rescue_from Forbidden, with: :rescue_forbidden

    private def login_required
        raise LoginRequired unless current_member
    end

    private def rescue_bad_request(exception)
        render "errors/bad_request", status: 400, layout: "error",
            formats: [:html]
    end

    private def rescue_login_required(exception)
        render "errors/login_required", status: 403, layout: "error",
            formats: [:html]
    end

    private def rescue_forbidden(exception)
        render "errors/forbidden", status: 403, layout: "error",
            formats: [:html]
    end

    private def rescue_not_found(exception)
        render "errors/not_found", status: 404, layout: "error",
            formats: [:html]
    end

    private def rescue_internal_server_error(exception)
        render "errors/internal_server_error", status: 500, layout: "error",
            formats: [:html]
    end

end
