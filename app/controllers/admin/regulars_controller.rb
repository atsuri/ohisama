class Admin::RegularsController < Admin::Base
    before_action :admin_login_required

    def index
        if params[:regular_item] == "regular_item"
            @member = Member.find(params[:member_id])
            @regular = Regular.where(member_id: @member.id)
        else
            @members = Member.where(regular_member: true)
        end
    end

    def search
        @members = Member.includes(:regulars).where(regular_member: true).search(params[:keyword])
            # .page(params[:page]).per(15)
        render "index"
    end
end
