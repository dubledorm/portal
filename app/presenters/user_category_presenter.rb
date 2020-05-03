class UserCategoryPresenter < BasePresenter
  include ActiveModel::Serializers::JSON

  attr_accessor :categories


  def initialize(model, view_context)
    super(model, view_context)
    @categories = get_categories_list
  end

  def attributes()
    { categories: categories }
  end

  private
  def get_categories_list
    result = []
    Tag.category.sort_by{ |category| category.title }.each do |category|
      result << { name: category.name,
                  title: category.title,
                  included: model.has_category?(category.name) }
    end
    result
  end
end