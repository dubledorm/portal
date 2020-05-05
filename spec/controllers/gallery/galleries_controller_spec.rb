require 'rails_helper'
require 'support/devise_support'


RSpec.describe GalleriesController, :type => :controller do

  context 'when authentication does not need' do

    context 'index#' do
      let!(:gallery) { FactoryGirl.create :gallery }

      before :each do
        get :index
      end

      it { expect(response).to have_http_status(200) }
      it { expect(assigns(:collection).count).to eq(1) }
    end

    context 'show#' do
      let!(:gallery) { FactoryGirl.create :gallery }

      before :each do
        get :show, params: { id: gallery.to_param }
      end

      it { expect(response).to render_template(:show) }
      it { expect(assigns(:resource).id).to eq(gallery.id) }
    end

    # context 'delete#' do
    #   let!(:user1) { FactoryGirl.create :user }
    #   let!(:gallery1) { FactoryGirl.create :gallery, user: user1 }
    #   subject { delete :destroy, params: { id: gallery1.id, user_id: user1.id }  }
    #
    #   before :each do
    #     subject
    #   end
    #
    #   it { expect{ subject }.to change(Gallery, :count).by(0) }
    #   it 'should return 403' do
    #     expect(response).to have_http_status(403)
    #   end
    # end
    #
    # context 'update#' do
    #   let!(:gallery1) { FactoryGirl.create :gallery }
    #   let!(:valid_attributes) { { name: 'new_gallery_name' } }
    #   subject { put :update, params: { id: gallery1.id, user_id: 0, gallery: valid_attributes } }
    #
    #   before :each do
    #     subject
    #   end
    #
    #   it { expect(response).to have_http_status(403) }
    # end
  end

  # context 'when need authentication' do
  #   include DeviseSupport
  #   let!(:user1) { FactoryGirl.create :user }
  #   let(:gallery) { FactoryGirl.build :gallery }
  #   let!(:gallery1) { FactoryGirl.create :gallery, user: user1 }
  #
  #   before :each do
  #     sign_in_user
  #   end
  #
  #   context 'new#' do
  #     subject { get :new, params: { user_id: @user.id }  }
  #     before :each do
  #       subject
  #     end
  #
  #     it { expect(response).to have_http_status(200) }
  #     it { expect(assigns(:resource)).to_not eq(nil) }
  #     it { expect(assigns(:user)).to_not eq(nil) }
  #     it { expect(response).to render_template(:new) }
  #   end
  #
  #   context 'create#' do
  #     subject { post :create, params: { user_id: @user.id, gallery: gallery.attributes }  }
  #
  #     it { expect{ subject }.to change(Gallery, :count).by(1) }
  #     it 'should return 302' do
  #       subject
  #       expect(response).to have_http_status(302)
  #     end
  #   end
  #
  #   context 'edit#' do
  #     let(:gallery) { FactoryGirl.create :gallery, user_id: @user.id }
  #     subject { get :edit, params: { id: gallery.id, user_id: @user.id }  }
  #     before :each do
  #       subject
  #     end
  #
  #     it { expect(response).to have_http_status(200) }
  #     it { expect(assigns(:resource)).to_not eq(nil) }
  #     it { expect(assigns(:user)).to_not eq(nil) }
  #     it { expect(response).to render_template(:edit) }
  #   end
  #
  #   context 'update#' do
  #     let!(:valid_attributes) { { name: 'new_gallery_name' } }
  #     let(:gallery) { FactoryGirl.create :gallery, user_id: @user.id }
  #     subject { put :update, params: { id: gallery.id, user_id: @user.id, gallery: valid_attributes }  }
  #
  #     before :each do
  #       subject
  #     end
  #
  #     it { expect(response).to have_http_status(302) }
  #     it 'should change gallery' do
  #       gallery.reload
  #       expect(gallery.name).to eq('new_gallery_name')
  #     end
  #   end
  #
  #   context 'forbidden update#' do
  #     let!(:valid_attributes) { { name: 'new_gallery_name' } }
  #     subject { put :update, params: { id: gallery1.id, user_id: @user.id, gallery: valid_attributes } }
  #
  #     before :each do
  #       subject
  #     end
  #
  #     it { expect(response).to have_http_status(403) }
  #   end
  # end
  #
  #
  # context 'delete#' do
  #   include DeviseSupport
  #   let!(:user) { FactoryGirl.create :user }
  #   let!(:gallery) { FactoryGirl.create :gallery, user_id: user.id }
  #   subject { delete :destroy, params: { id: gallery.id, user_id: user.id }  }
  #
  #   before :each do
  #     sign_in(user)
  #   end
  #
  #   it { expect{ subject }.to change(Gallery, :count).by(-1) }
  #   it 'should retirn 204' do
  #     subject
  #     expect(response).to have_http_status(204)
  #   end
  # end
  #
  # context 'forbidden delete#' do
  #   include DeviseSupport
  #   let!(:user) { FactoryGirl.create :user }
  #   let!(:user1) { FactoryGirl.create :user }
  #   let!(:gallery1) { FactoryGirl.create :gallery, user: user1 }
  #   subject { delete :destroy, params: { id: gallery1.id, user_id: user1.id }  }
  #
  #   before :each do
  #     sign_in(user)
  #   end
  #
  #   it { expect{ subject }.to change(Gallery, :count).by(0) }
  #   it 'should retirn 403' do
  #     subject
  #     expect(response).to have_http_status(403)
  #   end
  # end
end