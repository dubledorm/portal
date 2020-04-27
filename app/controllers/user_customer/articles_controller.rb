# encoding: utf-8
module UserCustomer
  class ArticlesController < ApplicationController

    before_action find_user

    include ArticleConcern

    def new
      super do
        @resource = Article.new(user_id: @user.id)
      end
    end

    def create
      super do
        @resource = Article.create(article_params)
        unless @resource.persisted?
          render :new
          return
        end
        redirect_to user_article_path(user_id: @user.id, id: @resource.id)
      end
    end

    def update
      super do
        @resource.update(article_params)

        respond_to do |format|
          if @resource.errors.count == 0
            format.html { redirect_to user_article_path(user_id: @user.id, id: @resource.id) }
            format.js
            format.json { render json: @resource, status: :ok, location: @resource }
          else
            format.html { render action: :edit }
            format.json { render json: @resource.errors, status: :unprocessable_entity }
          end
        end
      end
    end

    def show
      super do
        @user = User.find(params.required(:user_id))
      end
    end

    private

    def article_params
      params.required(:article).permit(:name, :main_description, :short_description, :state, :article_type,
                                       :min_quantity, :max_quantity, :min_age, :max_age, :seo_description,
                                       :seo_keywords, :duration_minutes, :gallery_id, :user_id)
    end

    def find_user
      @user = User.find(params.required(:user_id))
    end
  end
end