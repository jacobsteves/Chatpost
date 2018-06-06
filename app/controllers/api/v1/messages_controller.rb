module Api
  module V1
    class MessagesController < ApiController
      before_filter :authenticate_user!
      respond_to :json

      def create
        render :json=> {:success=>true}
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
