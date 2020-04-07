require 'auth/service_descr_manager'
require 'auth/omni_auth_error'

class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include OmniAuthConcern

  # Создать точки входа для всех провайдеров
  def self.provides_callback_for(provider)
    class_eval %Q{
      def #{provider}
        do_omniauth
      end
    }
  end

  Auth::ServiceDescrManager::KNOWN_SERVICES_DESCR.keys.each do |provider|
    provides_callback_for provider
  end

  # -----------------------------------------

  def failure
    redirect_to root_path
  end

  # It provides central callback for OmniAuth
  def do_omniauth
    begin
      aut_data = get_auth_data(request.env['omniauth.auth'], action_name)
      service = Service.find_by_provider_and_uid(aut_data[:provider], aut_data[:uid])


      if user_signed_in?                                     # Если пользователь уже вошёл под EMail (Например)
        create_service_and_redirect(service, aut_data)
        return
      end

      unless service.nil?
        # Войти на основании найденного сервиса
        sign_in_and_redirect(service)
        return
      end

      session[:aut_data] = aut_data
      redirect_to service_sign_up_users_path  # Переходим на ввод дополнительных параметров

    rescue Auth::OmniAuthBadProviderData, Auth::OmniAuthError => e
      flash[:error] = e.message
      redirect_to new_user_session_path
    end
  end

  def service_sign_up_users
    aut_data = session[:aut_data].to_h.symbolize_keys
    @user = User.new(email: aut_data[:email],
                     password: '',
                     password_confirmation: '')
  end

  def create_user_and_service
    begin
      aut_data = session[:aut_data].to_h.symbolize_keys
      aut_data = merge_auth_data_with_additional_parameters(aut_data, user_params.to_h.symbolize_keys)
      user = nil
      ActiveRecord::Base.transaction do
        # Может быть есть пользователь с таким email
        user = User.find_by_email(aut_data[:email]) unless aut_data[:email].blank?
        raise Auth::OmniAuthError, I18n.t('create_user.email_taken') unless user.nil?

        user = create_user(aut_data)
        create_service(user, aut_data)
      end
      sign_in(:user, user)
      redirect_to authenticated_root_path

    rescue Auth::OmniAuthError, ActiveRecord::RecordInvalid => e
      flash[:alert] = e.message
      redirect_to :service_sign_up_users
    end
  end

  private

  def user_params
    params.required(:user).permit(:email, :password, :password_confirmation)
  end
end