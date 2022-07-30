class Admin::SessionsController < Admin::Base
    def create
        member = Administrator.find(1) #カラム名
        if member&.authenticate(params[:password])
            cookies[:id] = { value: member.id, expires: 5.minutes.from_now }
            # cookies.signed[:member_id] = { value: member.id, expires: 5.seconds.from_now } # 5.minutes.from_now
        else
            flash.alert = "パスワードが一致しません"
        end
        redirect_to :admin_root
    end

    def destroy
        cookies.delete(:id)
        redirect_to :admin_root
    end
end
