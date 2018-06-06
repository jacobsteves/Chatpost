module Api
  module V1
    class MessagesController < LoggedInController

      ##
      # POST /api/v1/messages
      #
      # params = {
      #   conversation_id: 1,
      #   message: {
      #     body: "This is the message body."
      #   }
      # }
      def create
        conversation = Conversation.find(params[:conversation_id])
        message = conversation.messages.build(params[:message].to_h)
        message.user_id = current_user.id

        if message.save!
          render :json=> {:success => true, :message => message}
        else
          render :json=> {:success => false, :message => "Error creating message."}, :status => 500
        end
      end

      ##
      # GET /api/v1/message/1
      def show
        render :json => {
            :success => true,
            :message => Message.find(params[:id].to_i)
        }
      end

    end
  end
end
