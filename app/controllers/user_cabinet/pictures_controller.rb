# encoding: utf-8
module UserCabinet
  class PicturesController < PrivateAreaController

    def create
      super do
        ActiveRecord::Base.transaction do
          @resource = Picture.create(picture_params.merge!(gallery_id: params.require(:gallery_id),
                                                           state: :active))
        end
        if @resource.persisted?
          render json: attributes_mask_to_json(@resource, picture_params),  status: :created,
                 location: user_cabinet_gallery_picture_path(gallery_id: params[:gallery_id], id: @resource.id)
        else
          render json: @resource.errors.full_messages.join(', '), status: :unprocessable_entity
        end
      end
    end


    def update
      # super do
      #   presenter = UserGalleryPresenter.new(gallery_params)
      #   @resource = presenter.update(@resource, view_context)
      #   if @resource.errors.count == 0
      #     render json: attributes_mask_to_json(@resource, gallery_params),  status: :ok
      #   else
      #     render json: presenter.errors_to_json, status: :unprocessable_entity
      #   end
      # end
    end


    private

    def picture_params
      params.required(:picture).permit(:name, :description, :image, :state)
    end

    def menu_action_items
      ['user']
    end
  end
end