class UserProfilePresenter
  include ActiveModel::Model
  include ActiveModel::Serializers::JSON

  attr_reader :h
  attr_accessor :id, :nick_name, :avatar, :services, :email, :email_confirmed, :email_confirmed_message

  def initialize(user, context)
    @h = context
    @id = user.id
    @nick_name = user.nick_name
    @avatar = image_path(user)
    @services = get_services(user)
    @email = user.email
    @email_confirmed = user.user_confirmed?
    @email_confirmed_message = @email_confirmed ? '' : I18n.t('user.show.confirm_email', days: user.unconfirmed_days_still_available)
  end

  def attributes
    { id: id,
      email: email,
      nick_name: nick_name,
      avatar: avatar,
      email_confirmed: email_confirmed,
      email_confirmed_message: email_confirmed_message,
      services: services
    }
  end

  private

  def image_path(user)
    user.avatar.attached? ? h.url_for(user.avatar.variant(resize_to_limit: [200, 200])) : ''
  end

  def get_services(user)
    result = []
    Auth::ServiceDescrManager::KNOWN_SERVICES_DESCR.each do |service|
      service_id = (serv = user.services.by_provider(service[0]).first) && serv.id
      result << { provider_name: service[1].service_name,
                  provider: service[0],
                  icon_name: service[1].icon_name,
                  service_id: service_id,
                  included: !service_id.nil? }
    end
    result
  end
end