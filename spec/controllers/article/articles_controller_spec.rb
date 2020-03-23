require 'rails_helper'
require 'support/devise_support'


RSpec.describe ArticlesController, :type => :controller do

  context 'when authentication does not need' do

    context 'index#' do
      let!(:article) { FactoryGirl.create :article }

      before :each do
        get :index
      end

      it { expect(response).to have_http_status(200) }
      it { expect(assigns(:collection).count).to eq(1) }
    end

    context 'show#' do
      let!(:article) { FactoryGirl.create :article }

      before :each do
        get :show, params: { id: article.to_param }
      end

      it { expect(response).to render_template(:show) }
      it { expect(assigns(:resource).id).to eq(article.id) }
    end

    context 'delete#' do
      let!(:user1) { FactoryGirl.create :user }
      let!(:article1) { FactoryGirl.create :article, user: user1 }
      subject { delete :destroy, params: { id: article1.id, user_id: user1.id }  }

      before :each do
        subject
      end

      it { expect{ subject }.to change(Article, :count).by(0) }
      it 'should return 403' do
        expect(response).to have_http_status(403)
      end
    end

    context 'update#' do
      let!(:article1) { FactoryGirl.create :article }
      let!(:valid_attributes) { { name: 'new_name' } }
      subject { put :update, params: { id: article1.id, user_id: 0, article: valid_attributes } }

      before :each do
        subject
      end

      it { expect(response).to have_http_status(403) }
    end
  end

  context 'when need authentication' do
    include DeviseSupport
    let!(:user1) { FactoryGirl.create :user }
    let(:article) { FactoryGirl.build :article }
    let!(:article1) { FactoryGirl.create :article, user: user1 }

    before :each do
      sign_in_user
    end

    context 'new#' do
      subject { get :new, params: { user_id: @user.id }  }
      before :each do
        subject
      end

      it { expect(response).to have_http_status(200) }
      it { expect(assigns(:resource)).to_not eq(nil) }
      it { expect(response).to render_template(:new) }
    end

    context 'create#' do
      subject { post :create, params: { user_id: @user.id, article: article.attributes }  }

      it { expect{ subject }.to change(Article, :count).by(1) }
      it 'should return 302' do
        subject
        expect(response).to have_http_status(302)
      end
    end

    context 'edit#' do
      let(:article) { FactoryGirl.create :article, user_id: @user.id }
      subject { get :edit, params: { id: article.id, user_id: @user.id }  }
      before :each do
        subject
      end

      it { expect(response).to have_http_status(200) }
      it { expect(assigns(:resource)).to_not eq(nil) }
      it { expect(response).to render_template(:edit) }
    end

    context 'update#' do
      let!(:valid_attributes) { { name: 'new_name'  } }
      let(:article) { FactoryGirl.create :article, user_id: @user.id  }
      subject { put :update, params: { id: article.id, user_id: @user.id, article: valid_attributes }  }

      before :each do
        subject
      end

      it { expect(response).to have_http_status(302) }
      it 'should change article' do
        article.reload
        expect(article.name).to eq('new_name')
      end
    end

    context 'forbidden update#' do
      let!(:valid_attributes) { { name: 'new_name' } }
      subject { put :update, params: { id: article1.id, user_id: @user.id, article: valid_attributes } }

      before :each do
        subject
      end

      it { expect(response).to have_http_status(403) }
    end
  end


  context 'delete#' do
    include DeviseSupport
    let!(:user) { FactoryGirl.create :user }
    let!(:article) { FactoryGirl.create :article, user_id: user.id }
    subject { delete :destroy, params: { id: article.id, user_id: user.id }  }

    before :each do
      sign_in(user)
    end

    it { expect{ subject }.to change(Article, :count).by(-1) }
    it 'should return 204' do
      subject
      expect(response).to have_http_status(204)
    end
  end

  context 'forbidden delete#' do
    include DeviseSupport
    let!(:user) { FactoryGirl.create :user }
    let!(:user1) { FactoryGirl.create :user }
    let!(:article1) { FactoryGirl.create :article, user: user1 }
    subject { delete :destroy, params: { id: article1.id, user_id: user1.id }  }

    before :each do
      sign_in(user)
    end

    it { expect{ subject }.to change(Article, :count).by(0) }
    it 'should retirn 403' do
      subject
      expect(response).to have_http_status(403)
    end
  end
end