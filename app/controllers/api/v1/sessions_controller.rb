module Api
  module V1
    class SessionsController < Devise::SessionsController
      prepend_before_filter :require_no_authentication, :only => [:create ]
      skip_before_filter :verify_authenticity_token, :only => [:create ]
      respond_to :json

      def create
        resource = User.find_for_database_authentication(:email=>params[:user][:email])
        return invalid_login_attempt unless resource

        if resource.valid_password?(params[:user][:password])
          sign_in("user", resource)
          render :json=> {:success=>true, :user_name=>resource.name, :email=>resource.email}
          return
        end
        invalid_login_attempt
      end

      def destroy
        sign_out(resource_name)
      end

      protected
      def ensure_params_exist
        return unless params[:user_login].blank?
        render :json=>{:success=>false, :message=>"missing user_login parameter"}, :status=>422
      end

      def invalid_login_attempt
        warden.custom_failure!
        render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
      end
    end
  end
end
