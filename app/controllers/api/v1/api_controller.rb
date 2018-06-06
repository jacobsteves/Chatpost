module Api
  module V1
    class ApiController < ActionController::Base


      private

      def authenticate!
        bad_request!("Secret and Public key most both be present in the parameters or headers in order to use the API. See https://www.bananastand.io/resources/private-rest-api for more information.") unless secret_key.present? && public_key.present?

        @store = Store.find_by!(secret_key: secret_key, public_key: public_key)
      end

      def secret_key
        @secret_key ||= request.headers['X-Secret-Key'] || params[:secret_key].to_s.strip
      end

      def public_key
        @public_key ||= request.headers['X-Public-Key'] || params[:public_key].to_s.strip
      end

      def account
        @store.account
      end
    end
  end
end
