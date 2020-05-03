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
        presenter = UserGalleryPresenter.new(view_context, gallery_params)
        @resource = presenter.create
        if @resource.persisted?
          redirect_to user_gallery_path(user_id: @resource.user_id, id: @resource.id)
          return
        end
        render :new
      end
    end


    def update
      super do
        presenter = UserGalleryPresenter.new(view_context, @resource.attributes.merge!(gallery_params))
        @resource = presenter.update(@resource)
        if @resource.errors.count == 0
          render json: Hash[*gallery_params.keys.map{|key| [key, @resource.decorate.send(key)]}.flatten],  status: :ok
        else
          render json: @resource.errors, status: :unprocessable_entity
        end
      end
    end


    private

    def gallery_params
      params.required(:gallery).permit(:name, :description, :user_id, :image_for_cover)
    end

    def menu_action_items
      ['user']
    end
  end
end