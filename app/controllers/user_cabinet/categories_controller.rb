# encoding: utf-8

module UserCabinet
  class CategoriesController < PrivateUserController

    def update
      super do
        presenter = UserCategoryPresenter.new.from_json_string(user_categories_params[:categories])
        ActiveRecord::Base.transaction do
          @resource.clear_categories
          presenter.categories.each do |category|
            @resource.add_category(category[:name])
          end
        end

        render json: presenter.to_json,  status: :ok
      end
    end

    def user_categories_params
      params.required(:user).permit(:categories)
    end

  end
end