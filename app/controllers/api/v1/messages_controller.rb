module Api
  module V1
    class MessagesController < LoggedInController

      def create
        conversation = Conversation.find(params[:conversation_id])
        message = conversation.messages.build(params[:message].to_h)
        message.user_id = current_user.id

        if message.save!
          render :json=> {:success=>true, :message=>message}
        else
          render :json=> {:success=>false, :message=>"Error creating message."}, :status=>500
        end
      end

      def show
        render :json => {
            :success => true,
            :message => Message.find(params[:id].to_i)
        }
      end

    end
  end
end
