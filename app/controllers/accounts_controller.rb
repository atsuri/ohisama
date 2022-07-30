class AccountsController < ApplicationController
    before_action :login_required, except: [:new, :create]

    def show
        @member = current_member
    end

    def new
        @member = Member.new()
    end

    def edit
        @member = current_member
    end

    def create
        @member = Member.new(account_params)
        if @member.save
            cookies[:member_id] = { value: @member.id, expires: 5.minutes.from_now }
            regular_new #Regular作成
            redirect_to :root, notice: "会員登録が完了しました。"
        else
            render "new"
        end
    end

    def update
        @member = current_member
        @member.assign_attributes(account_params)
        if @member.save
            redirect_to :account, notice: "アカウント情報を更新しました。"
        else
            render "edit"
        end
    end

    private def account_params
        params.require(:account).permit(
            :user_id,
            :address,
            :name,
            :regular_member,
            :group,
            :password,
            :password_confirmation
        )
    end
end
