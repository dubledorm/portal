module OmniAuthConcern
  extend ActiveSupport::Concern

  # Преобразовать данные от провайдера к единой структуре
  def get_auth_data(omniauth, service_route)
    Auth::ServiceDescrManager.new(service_route).get_auth_data(omniauth)
  end

  # Войти под полученным от провайдера пользователем, либо зарегистрировать его, если такого нет
  def sign_in_or_sign_up(aut_data)
    service = Service.find_by_provider_and_uid(aut_data[:provider], aut_data[:uid])

    if user_signed_in?                                     # Если пользователь уже вошёл под EMail (Например)
      service = create_service(current_user, aut_data) if service.nil? # Привязать к сервису если не привязан

      # Проверяем случай, когда такой сервис уже существует, но для другово пользователя
      raise Auth::OmniAuthError, I18n.t('sign_in.error_service_exists',
                                  provider_name: aut_data[:provider_name]) if service.user != current_user
      return service
    end

    # Зарегистрировать нового пользователя
    if service.nil?
      user = nil
      # Может быть есть пользователь с таким email
      user = User.find_by_email(aut_data[:email]) unless aut_data[:email].blank?
      # Создать если не найден
      user = create_user(aut_data) if user.nil?
      service = create_service(user, aut_data) # Привязать к сервису
    end

    # Войти на основании найденного сервиса
    sign_in(:user, service.user)                            # Войти, взяв пользователя из найденного сервиса
    raise Auth::OmniAuthError, I18n.t('sign_in.error_during', user_name: service.user.email) unless user_signed_in?
    service
  end


  private

  # Создать новый сервис. Связать пользователя системы с провайдером
  def create_service(user, aut_data)
    user.services.create(provider: aut_data[:provider],
                         uid: aut_data[:uid],
                         uname: aut_data[:name],
                         uemail: aut_data[:email])
  end

  def create_user(aut_data)
    raise Auth::OmniAuthError, I18n.t('create_user.need_email', provider_name: aut_data[:provider_name]) if aut_data[:email].blank?
    User.create!(email: aut_data[:email],
                password: SecureRandom.hex(10))
  end
end