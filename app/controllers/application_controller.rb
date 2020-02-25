class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :configure_permitted_parameters, if: :devise_controller?
  include BaseConcern

  rescue_from Exception, :with => :render_500
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  rescue_from ActionController::ParameterMissing, :with => :render_400
  rescue_from ActionController::BadRequest, :with => :render_400

  # страница не найдена
  def render_404(e)
    Rails.logger.error(e.message)
    render 'errors/404', status: :not_found
  end

  # ошибка в параметрах запроса
  def render_400(e)
    Rails.logger.error(e.message)
    render 'errors/400', status: :bad_request
  end

  # внутрення ошибка сервера. не обработанная ошибка
  def render_500(e)
    Rails.logger.error(e.message)
    render 'errors/500', status: 500
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar])
  end
end
