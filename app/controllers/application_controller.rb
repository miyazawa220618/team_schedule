class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :configure_permitted_parameters, if: :devise_controller?

  # unless Rails.env.development?
  #   rescue_from Exception,                      with: :render_500
  #   rescue_from ActiveRecord::RecordNotFound,   with: :render_404
  #   rescue_from ActionController::RoutingError, with: :render_404
  # end
 
  # def routing_error
  #   raise ActionController::RoutingError, params[:path]
  # end

  private
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  def after_sign_in_path_for(resource)
    if user_signed_in?
    user_path(current_user.id)
   else
    new_user_session_path
   end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
      keys: [:nickname, :work_id, :profile_text, :profile_image])
      devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :work_id, :profile_text, :profile_image])
  end

  def render_404
    render 'error/404', status: :not_found
  end

  def render_500
    render 'error/500', status: :internal_server_error
  end
end
