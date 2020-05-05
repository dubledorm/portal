class GalleryDecorator < Draper::Decorator
  include Rails.application.routes.url_helpers
  delegate_all

  def image_for_cover
    begin
      return rails_representation_url(object.image_for_cover.variant(resize_to_limit: [600, 600]).processed,
                                      only_path: true) if object.image_for_cover.attached?
    rescue Exception => e
      Rails.logger.error('GalleryDecorator.image_for_cover.error: ' + e.message)
    end
    ActionController::Base.helpers.asset_path('images/sidebar-g-1.png')
  end
end