class MembersController < ApplicationController
    before_action :login_required

    #会員一覧
    def index
        @members = Member.order("number")
            .page(params[:page]).per(15)
    end

    #検索
    def search
        @members = Member.search(params[:q])
            .page(params[:page]).per(15) 
        # TODO: 授業内課題04
        if params[:m].present? || params[:w].present?
            @members = @members.where(sex: [params[:m], params[:w]])
                # .page(params[:page]).per(15) 
        end

        render "index"
    end

    def show
        @member = Member.find(params[:id])
    end

    #ストロングパラメータ
    private def member_params
        attrs = [
            :new_profile_picture,
            :remove_profile_picture,
            :number,
            :name,
            :full_name,
            :sex,
            :birthday,
            :email,
            :administrator
        ]

        attrs << :password if params[:action] == "create"

        params.require(:member).permit(attrs)
    end

#     #新規作成フォーム
#     def new
#         @member = Member.new(birthday: Date.new(1989, 1, 1))
#     end

#     #更新フォーム
#     def edit
#         @member = Member.find(params[:id])
#     end
    
#     #会員の新規登録
#     def create
#         @member = Member.new(params[:member])
#         if @member.save
#             redirect_to @member, notice: "会員を登録しました。"
#         else
#             render "new"
#         end
#     end

#     #会員情報の更新
#     def update
#         @member = Member.find(params[:id])
#         @member.assign_attributes(params[:member])
#         if @member.save
#             redirect_to @member, notice: "会員情報を更新しました。"
#         else
#             render "edit"
#         end
#     end

#     #会員の削除
#     def destroy
#         @member = Member.find(params[:id])
#         @member.destroy
#         redirect_to :members, notice: "会員を削除しました。"
#     end
end
