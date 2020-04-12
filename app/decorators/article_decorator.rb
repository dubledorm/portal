class ArticleDecorator < Draper::Decorator
  delegate_all

  def main_description
    return object.main_description unless object.main_description.nil?
    I18n.t('not_defined_yet')
  end
end