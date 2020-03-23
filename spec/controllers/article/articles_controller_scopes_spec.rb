require 'rails_helper'
require 'support/devise_support'

shared_examples 'return one record' do
  context 'one record' do
    before :each do
      get :index, params: params
    end

    it { expect(response).to have_http_status(200) }
    it { expect(assigns(:collection).count).to eq(1) }
    it { expect(assigns(:collection).first).to eq(response_article) }
  end
end


RSpec.describe ArticlesController, :type => :controller do

  context 'when authentication does not need' do

    describe 'index#' do
      let!(:article) {FactoryGirl.create :article}
      let!(:article1) {FactoryGirl.create :article, article_type: :product}
      let!(:article2) {FactoryGirl.create :article, state: :draft}
      let!(:article3) {FactoryGirl.create :article, min_age: 10}
      let!(:article4) {FactoryGirl.create :article, max_age: 20}
      let!(:article5) {FactoryGirl.create :article, min_quantity: 3}
      let!(:article6) {FactoryGirl.create :article, max_quantity: 100}

      it_should_behave_like 'return one record' do
        let!(:response_article) { article1 }
        let!(:params) { { article_type: :product } }
      end

      it_should_behave_like 'return one record' do
        let!(:response_article) { article2 }
        let!(:params) { { state: :draft } }
      end

      it_should_behave_like 'return one record' do
        let!(:response_article) { article1 }
        let!(:params) { { user_id: article1.user_id } }
      end

      it_should_behave_like 'return one record' do
        let!(:response_article) { article3 }
        let!(:params) { { min_age: 12 } }
      end

      it_should_behave_like 'return one record' do
        let!(:response_article) { article4 }
        let!(:params) { { max_age: 12 } }
      end

      it_should_behave_like 'return one record' do
        let!(:response_article) { article5 }
        let!(:params) { { min_quantity: 12 } }
      end

      it_should_behave_like 'return one record' do
        let!(:response_article) { article6 }
        let!(:params) { { max_quantity: 12 } }
      end
    end
  end
end