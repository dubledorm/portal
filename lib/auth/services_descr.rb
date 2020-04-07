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

    def service_name
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

      result[:email] =  omniauth['extra']['user_hash']['email']
      result[:name] =  omniauth['extra']['user_hash']['name']
      result[:uid] =  omniauth['extra']['user_hash']['id']
      result[:provider] =  omniauth['provider']
      result
    end

    def icon_name
      'facebook_64.png'
    end

    def service_name
      'Facebook'
    end
  end

  class Github < BaseServiceDescr
    # Преобразовать данные, полученные от провайдера в единый формат
    def get_auth_data(omniauth)
      ap(omniauth)
      result = { email: '',
                 name: '',
                 uid: '',
                 provider: '' }

      result[:email] =  omniauth['extra']['raw_info']['email']
      result[:name] =  omniauth['extra']['raw_info']['name']
      result[:uid] =  omniauth['extra']['raw_info']['id']
      result[:provider] =  omniauth['provider']
      result
    end

    def icon_name
      'github_64.png'
    end

    def service_name
      'GitHub'
    end
  end

  class Vkontakte < BaseServiceDescr
    # Преобразовать данные, полученные от провайдера в единый формат
    def get_auth_data(omniauth)
      result = { email: '',
                 name: '',
                 uid: '',
                 provider: '' }
      ap(omniauth)
      result[:email] =  omniauth['extra']['raw_info']['email']
      result[:name] =  omniauth['extra']['raw_info']['last_name'] + ' ' + omniauth['extra']['raw_info']['first_name']
      result[:uid] =  omniauth['extra']['raw_info']['id']
      result[:provider] =  omniauth['provider']
      result
    end

    def icon_name
      'vkontakte_64.png'
    end

    def service_name
      'VKontakte'
    end
  end
end