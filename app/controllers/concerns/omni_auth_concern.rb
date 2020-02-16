module OmniAuthConcern
  extend ActiveSupport::Concern

  class OmniAuthError < StandardError; end;

  # Преобразовать данные от провайдера к единой структуре
  def get_auth_data(omniauth, service_route)
    case service_route
    when 'facebook'
      aut_data = get_auth_data_facebook(omniauth)
    else
      raise OmniAuthError, I18n.t('get_auth_data.provider_name_error', provider_name: service_route.capitalize)
    end
    raise OmniAuthError, I18n.t('get_auth_data.provider_bad_aut_data',
                                provider_name: service_route.capitalize) if aut_data[:uid].blank? || aut_data[:provider].blank?
    aut_data
  end

  # Войти под полученным от провайдера пользователем, либо зарегистрировать его, если такого нет
  def sign_in_or_sign_up(aut_data)
    service = Service.find_by_provider_and_uid(aut_data[:provider], aut_data[:uid])

    if user_signed_in?                                     # Если пользователь уже вошёл под EMail (Например)
      service = create_service(current_user, aut_data) if service.nil? # Привязать к сервису если не привязан

      # Проверяем случай, когда такой сервис уже существует, но для другово пользователя
      raise OmniAuthError, I18n.t('sign_in.error_service_exists',
                                  provider_name: aut_data[:provider_name]) if service.user != current_user
      return service
    end

    # Зарегистрировать нового пользователя
    if service.nil?
      # Может быть есть пользователь с таким email
      user = User.find_by_email(aut_data[:email]) unless aut_data[:email].blank?
      # Создать если не найден
      user = create_user(aut_data) if user.nil?
      service = create_service(user, aut_data) # Привязать к сервису
    end

    # Войти на основании найденного сервиса
    sign_in(:user, service.user)                            # Войти, взяв пользователя из найденного сервиса
    raise OmniAuthError, I18n.t('sign_in.error_during', user_name: service.user.email) unless user_signed_in?
    service
  end


  private

  def get_auth_data_facebook(omniauth)
    result = { email: '',
               name: '',
               uid: '',
               provider: '' }

    result[:email] =  omniauth['extra']['user_hash']['email'] if omniauth['extra']['user_hash']['email']
    result[:name] =  omniauth['extra']['user_hash']['name'] if omniauth['extra']['user_hash']['name']
    result[:uid] =  omniauth['extra']['user_hash']['id'] if omniauth['extra']['user_hash']['id']
    result[:provider] =  omniauth['provider'] if omniauth['provider']
    result
  end

  # Создать новый сервис. Связать пользователя системы с провайдером
  def create_service(user, aut_data)
    user.services.create(provider: aut_data[:provider],
                         uid: aut_data[:uid],
                         uname: aut_data[:name],
                         uemail: aut_data[:email])
  end

  def create_user(aut_data)
    raise OmniAuthError, I18n.t('create_user.need_email', provider_name: aut_data[:provider_name]) if aut_data[:email].blank?
    User.create!(email: aut_data[:email],
                password: SecureRandom.hex(10))
  end
end