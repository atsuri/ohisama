class SessionsController < ApplicationController
    def create
        member = Member.find_by(user_id: params[:user_id]) #カラム名
        if member&.authenticate(params[:password])
            cookies[:member_id] = { value: member.id, expires: 5.minutes.from_now } # 5.minutes.from_now
            # cookies.signed[:member_id] = { value: member.id, expires: 5.seconds.from_now } # 5.minutes.from_now
        else
            flash.alert = "名前とパスワードが一致しません"
        end
        redirect_to :root
    end

    def destroy
        cookies.delete(:member_id)
        redirect_to :root
    end
end
