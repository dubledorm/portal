module OmniAuthConcern
  extend ActiveSupport::Concern

  # Преобразовать данные от провайдера к единой структуре
  def get_auth_data(omniauth, service_route)
    raise Auth::OmniAuthError, I18n.t('get_auth_data.omniauth_nil_error',
                                      provider_name: service_route) if omniauth.nil?

    Auth::ServiceDescrManager.new(service_route).get_auth_data(omniauth)
  end

  # Создать новый сервис. Связать пользователя системы с провайдером
  def create_service(user, aut_data)
    user.services.create(provider: aut_data[:provider],
                         uid: aut_data[:uid],
                         uname: aut_data[:name],
                         uemail: aut_data[:email])
  end

  def create_user(aut_data)
    raise Auth::OmniAuthError, I18n.t('create_user.need_email', provider_name: aut_data[:provider_name]) if aut_data[:email].blank?
    raise Auth::OmniAuthError, I18n.t('create_user.need_password', provider_name: aut_data[:provider_name]) if aut_data[:password].blank?
    raise Auth::OmniAuthError, I18n.t('create_user.need_password_confirmation', provider_name: aut_data[:provider_name]) if aut_data[:password_confirmation].blank?

    User.create!(email: aut_data[:email],
                 password: aut_data[:password],
                 password_confirmation: aut_data[:password_confirmation])
    end


  def merge_auth_data_with_additional_parameters(aut_data, additional_parameters)
    return aut_data if additional_parameters.nil?
    aut_data.merge!(additional_parameters.find_all{|key, value| !value.blank? }.to_h.symbolize_keys)
  end

  def create_service_and_redirect(service, aut_data)
    service = create_service(current_user, aut_data) if service.nil? # Привязать к сервису если не привязан

    # Проверяем случай, когда такой сервис уже существует, но для другово пользователя
    raise Auth::OmniAuthError, I18n.t('sign_in.error_service_exists',
                                      provider_name: aut_data[:provider_name]) if service.user != current_user
    redirect_to authenticated_root_path
  end

  def sign_in_and_redirect(service)
    sign_in(:user, service.user)                            # Войти, взяв пользователя из найденного сервиса
    raise Auth::OmniAuthError, I18n.t('sign_in.error_during', user_name: service.user.email) unless user_signed_in?
    redirect_to authenticated_root_path
  end
end