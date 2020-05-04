# encoding: utf-8

module UserCabinet
  class CategoriesController < PrivateUserController

    def update
      super do
        categories = UserCategorySerializer.parse_string(user_categories_params[:categories])
        @resource.clear_categories
        categories.each do |category|
          @resource.add_category(category[:name])
        end

        presenter = UserCategorySerializer.new(@resource)
        render json: presenter,  status: :ok
      end
    end

    def user_categories_params
      params.required(:user).permit(:categories)
    end

  end
end