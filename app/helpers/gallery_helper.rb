module GalleryHelper

  def gallery_description(gallery)
    return gallery.description unless gallery.description.blank?

    content_tag(:h4, I18n.t('not_defined_yet_it') )
  end
end