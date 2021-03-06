class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?

    def after_sign_in_path_for(resource)
    	user_path(resource)
	end

	def after_sign_out_path_for(resource)
    	root_path
	end

	protected

	def configure_permitted_parameters
	    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email]) #sign_upの際に名前でのデータ操作を許可
	end

	# 回答参考 ログインユーザーがいなければ入れなく、いればユーザーIDが等しいか確認する？
	def correct_user?(user)
      if current_user.nil?
        return false
      else
        user.id.equal?(current_user.id)
      end
    end
end
