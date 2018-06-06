module Api
  module V1
    class LoggedInController < ApiController
      before_filter :authenticate_user!
      respond_to :json
    end
  end
end
