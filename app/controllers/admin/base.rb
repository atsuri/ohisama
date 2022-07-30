class Admin::Base < ApplicationController
    before_action :update_expiration_time_admin
    # before_action :admin_login_required

    # private def admin_login_required
    #     raise Forbidden unless current_admin&.administrator?
    # end    
end