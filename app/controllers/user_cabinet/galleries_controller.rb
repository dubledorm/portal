# encoding: utf-8
module UserCabinet
  class GalleriesController < PrivateAreaController

    def new
      super do
        @resource = Gallery.new
      end
    end

    def create
      super do
        presenter = UserGalleryPresenter.new
        @resource = presenter.create(view_context)
        if @resource.persisted?
          redirect_to user_cabinet_gallery_path(id: @resource.id)
          return
        end
        render :new
      end
    end


    def update
      super do
        presenter = UserGalleryPresenter.new(gallery_params)
        @resource = presenter.update(@resource, view_context)
        if @resource.errors.count == 0
          render json: attributes_mask_to_json(@resource, gallery_params),  status: :ok
        else
          render json: presenter.errors_to_json, status: :unprocessable_entity
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