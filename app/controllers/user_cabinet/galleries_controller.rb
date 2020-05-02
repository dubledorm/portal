# encoding: utf-8
module UserCabinet
  class GalleriesController < ApplicationController

    def new
      super do
        @resource = Gallery.new
      end
    end

    def create
      super do
        presenter = UserGalleryPresenter.new(gallery_params)
        @resource = presenter.save(view_context)
        if @resource.persisted?
          redirect_to user_gallery_path(user_id: @resource.user_id, id: @resource.id)
          return
        end
        render :new
      end
    end


    def update
      super do
        presenter = UserGalleryPresenter.new(gallery_params)
        @resource = presenter.save(view_context)
        if @resource.errors.count == 0
          render json: Hash[*gallery_params.keys.map{|key| [key, presenter.send(key)]}.flatten],  status: :ok
        else
          render json: @resource.errors, status: :unprocessable_entity
        end
      end
    end

    # def update1
    #   super do
    #     @user = User.find(params[:user_id])
    #     if gallery_params[:name].blank?
    #       @resource.errors[:name] << I18n.t('forms.gallery_new.need_name')
    #       render :edit
    #       return
    #     end
    #
    #     @resource.update(gallery_params)
    #     if @resource.errors.count > 0
    #       render :edit
    #       return
    #     end
    #     redirect_to user_gallery_path(user_id: params[:user_id], id: @resource.id)
    #   end
    # end

    private

    def gallery_params
      params.required(:gallery).permit(:name, :description, :user_id, :image_for_cover)
    end

    def menu_action_items
      ['user']
    end
  end
end