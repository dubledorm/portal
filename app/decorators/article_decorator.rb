class ArticleDecorator < Draper::Decorator
  delegate_all

  def main_description
    return object.main_description unless object.main_description.nil?
    I18n.t('not_defined_yet_it')
  end

  def short_description
    return object.short_description unless object.short_description.nil?
    I18n.t('not_defined_yet_it')
  end

  def min_quantity
    return object.min_quantity unless object.min_quantity.nil?
    I18n.t('not_defined_yet_it')
  end

  def max_quantity
    return object.max_quantity unless object.max_quantity.nil?
    I18n.t('not_defined_yet_it')
  end

  def min_age
    return object.min_age unless object.min_age.nil?
    I18n.t('not_defined_yet_it')
  end

  def max_age
    return object.max_age unless object.max_age.nil?
    I18n.t('not_defined_yet_it')
  end

  def seo_description
    return object.seo_description unless object.seo_description.nil?
    I18n.t('not_defined_yet_it')
  end

  def seo_keywords
    return object.seo_keywords unless object.seo_keywords.nil?
    I18n.t('not_defined_yet_it')
  end

end