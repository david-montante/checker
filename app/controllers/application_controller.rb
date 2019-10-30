class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  before_action :configure_permitted_parameters, if: :devise_controller?
    
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActionController::ParameterMissing, with: :render_invalid_parameter

  def routing_error
    render json: { status: :not_found, message: 'URL inválida'}, status: :not_found
  end

  def after_sign_in_path_for(resource)
    dashboard_users_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u|
      u.permit(:first_name, :last_name, :email, :password,
               :password_confirmation)
    }
  end

  def render_not_found(exception)
    render json: { success: false, errors: 'Registro no encontrado' }, 
                   status: :not_found
  end

  def render_invalid_parameter(exception)
    render json: { success: false, errors: 'Datos inválidos' }, 
                   status: :unprocessable_entity
  end
end
