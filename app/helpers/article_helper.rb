module ArticleHelper

  def article_types_array
    Article::ARTICLE_TYPES.map{ |article_type| [I18n.t("activerecord.values.article.article_type.#{article_type}"), article_type] }
  end

  def article_states_array
    Article::ARTICLE_STATES.map{ |article_state| [I18n.t("activerecord.values.article.state.#{article_state}"), article_state] }
  end
end