class UserCategoryPresenter < BasePresenter
  attr_accessor :categories


  def initialize(model, view_context)
    super(model, view_context)
    @categories = []
  end
end