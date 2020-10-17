require 'rails_helper'
require 'support/devise_support'
require 'support/shared/request_shared_examples'


RSpec.describe 'Picture', type: :request do
  describe 'create#' do
    include DeviseSupport
    before :each do
      sign_in_user
    end

    let(:gallery) {  FactoryGirl.create :gallery, user_id: @user.id}
    let!(:attributes) { { name: 'name' } }
    let(:subject) { post(user_cabinet_gallery_pictures_path(gallery_id: gallery.id, picture: attributes )) }


    it { expect{ subject }.to change(Picture, :count).by(1) }
  end
end