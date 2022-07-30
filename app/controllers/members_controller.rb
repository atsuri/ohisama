class MembersController < ApplicationController
    before_action :login_required

    #会員一覧
    def index
        @members = Member.order("name")
            # .page(params[:page]).per(15)
    end

    #検索
    def search
        @members = Member.search(params[:q])
            # .page(params[:page]).per(15) 
        render "index"
    end

    def show
        @member = Member.find(params[:id])
        # @regular = Regular.where(member_id: @member.id)
    end
  
    private def member_params
        attrs = [
            :user_id,
            :address,
            :name,
            :regular_member,
            :group
        ]
        attrs << :password if params[:action] == "create"

        params.require(:member).permit(attrs)
    end
end