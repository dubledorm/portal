# encoding: utf-8
module UserCabinet
  class ArticlesController < PrivateAreaController

    def new
      super do
        @resource = Article.new(user_id: current_user.id)
      end
    end

    def create
      super do
        @resource = Article.create(article_params.merge!(user_id: current_user.id,
                                                         state: :draft,
                                                         article_type: :service))
        unless @resource.persisted?
          render :new
          return
        end
        redirect_to user_cabinet_article_path(id: @resource.id)
      end
    end

    def update
      super do
        @resource.update(article_params)
        if @resource.errors.count == 0
          render json: attributes_mask_to_json(@resource, article_params),  status: :ok
        else
          render json: @resource.errors.full_messages.join(', '), status: :unprocessable_entity
        end
      end
    end

    def destroy
      super do
        ActiveRecord::Base.transaction do
          @resource.destroy!
        end
        redirect_to user_cabinet_path
      end
    end

    private

    def article_params
      params.required(:article).permit(:name, :main_description, :short_description, :state, :article_type,
                                       :min_quantity, :max_quantity, :min_age, :max_age, :seo_description,
                                       :seo_keywords, :duration_minutes, :main_image)
    end

    def menu_action_items
      ['user']
    end
  end
end