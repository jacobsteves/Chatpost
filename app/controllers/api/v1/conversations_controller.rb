module Api
  module V1
    class ConversationsController < LoggedInController

      ##
      # POST /api/v1/conversations
      #
      # params = {
      #   sender_id: 1,
      #   recipient_id: 2
      # }
      def create
        if Conversation.between(params[:sender_id],params[:recipient_id]).present?
          @conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
        else
          @conversation = Conversation.create!(create_conversation_params)
        end

        render json: { conversation_id: @conversation.id }
      end

      ##
      # GET /api/v1/conversations/i
      def show
        render :json => {
            :success => true,
            :conversation => Conversation.find(params[:id].to_i)
        }
      end

      private

      def create_conversation_params
        params.permit(:sender_id, :recipient_id)
      end

    end
  end
end
