# encoding: UTF-8
require 'auth/services_descr'

module Auth
  class ServiceDescrManager
    KNOWN_SERVICES_DESCR = { 'facebook' => Auth::ServicesDescr::Facebook.new,
                              'github' => Auth::ServicesDescr::Github.new,
                              'vkontakte' => Auth::ServicesDescr::Vkontakte.new }.freeze

    def initialize(service_descr_type)
      @service_descr = KNOWN_SERVICES_DESCR[service_descr_type]
      @service_descr_name = service_descr_type.capitalize
      raise Auth::OmniAuthError, I18n.t('get_auth_data.provider_name_error',
                                  provider_name: service_descr_name) if service_descr.nil?
    end

    def get_auth_data(omniauth)
      begin
        ap(omniauth)
        service_descr.get_auth_data(omniauth)
      rescue StandardError => e
        raise Auth::OmniAuthBadProviderData, I18n.t('get_auth_data.provider_data_error',
                                                    provider_name: service_descr_name,
                                                    data: omniauth,
                                                    message: e.message)
      end
    end

    def icon_name
      service_descr.icon_name
    end

    def service_name
      service_descr.service_name
    end

    private
    attr_accessor :service_descr, :service_descr_name
  end
end