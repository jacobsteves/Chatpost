class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_user
  before_action :load_conversations

  protected

  def load_conversations
    return unless user_signed_in?
    @users = User.where.not("id = ?",current_user.id).order("created_at DESC")
    @conversations = Conversation.involving(current_user).order("created_at DESC")
  end

  def not_found(exception = nil)
    Rails.logger.warn("Triggered routing error manually from ApplicationController." + (exception.present? ? "Specific error was: #{exception.inspect}" : ''))

    raise ActionController::RoutingError.new('Page not Found')
  end

  def set_user
    @user = @current_user
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
