class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :confirm_password_reset, unless: :devise_controller?

    protected

    def confirm_password_reset
        if current_user.is_password_reset_required
            current_user.update!(password_changed_at: nil)
            redirect_to user_password_expired_path
        end
    end

end
