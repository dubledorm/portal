# encoding: utf-8
class GalleriesController < ApplicationController
  # def new
  #   super do
  #     @user = User.find(params.required(:user_id))
  #     @resource = Gallery.new(user_id: params.required(:user_id))
  #   end
  # end

  def edit
    super do
      @user = current_user
    end
  end

  # def create
  #   super do
  #     @resource = Gallery.new(gallery_params.merge({ state: 'active' }))
  #     if !@resource.name.blank?
  #       @resource.save
  #       if @resource.persisted?
  #         redirect_to user_gallery_path(user_id: gallery_params[:user_id], id: @resource.id)
  #         return
  #       end
  #     else
  #       @resource.errors[:name] << I18n.t('forms.gallery_new.need_name')
  #     end
  #     @user = User.find(params[:user_id])
  #     render :new
  #   end
  # end

  # def update
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
  #     redirect_to user_gallery_path(user_id: gallery_params[:user_id], id: @resource.id)
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
