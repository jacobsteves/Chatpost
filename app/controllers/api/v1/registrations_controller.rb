module Api
  module V1
    class RegistrationsController < ApiController

      respond_to :json
      def create

        user = User.new(params[:user])
        if user.save
          render :json=> { :token=>user.authentication_token, :email=>user.email }, :status=>201
          return
        else
          warden.custom_failure!
          render :json=> user.errors, :status=>422
        end
      end
    end
  end
end
