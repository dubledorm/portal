# encoding: UTF-8

module Auth::ServicesDescr

  class BaseServiceDescr

    # Преобразовать данные, полученные от провайдера в единый формат
    def get_auth_data(omniauth)
      raise NotImplementedError
    end

    def icon_name
      raise NotImplementedError
    end
  end

  class Facebook < BaseServiceDescr
    # Преобразовать данные, полученные от провайдера в единый формат
    def get_auth_data(omniauth)
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

    def icon_name
      'facebook_64.png'
    end
  end
end