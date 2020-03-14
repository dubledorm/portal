require 'rails_helper'
require 'support/devise_support'
require 'support/shared/request_shared_examples'


RSpec.describe 'Article', type: :request do

  describe 'index#' do
    let!(:article1) {FactoryGirl.create :article}

    context 'when good requets' do
      it 'should return record' do
        get(articles_path())
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'create#' do
    include DeviseSupport
    let(:article) { FactoryGirl.build :article }
    let(:subject) { post(articles_path(), params: { article: article.attributes }) }

    before :each do
      sign_in_user
    end

    it { expect{ subject }.to change(Article, :count).by(1) }
  end

  describe 'update#' do
    include DeviseSupport

    context 'when we are owner of the record' do
      let(:article) { FactoryGirl.create :article,  user: @user }
      let(:subject) { put(article_path(article), params: { article: { name: 'new_name' } }) }

      before :each do
        sign_in_user
        subject
        article.reload
      end

      it { expect(article.name).to eq('new_name') }
    end

    context 'when we are not owner of the record' do
      let!(:article) { FactoryGirl.create :article }

      before :each do
        sign_in_user
      end

      it_should_behave_like 'get response 403' do
        subject { put(article_path(article), params: { article: { name: 'new_name' } })  }
      end
    end
  end

  describe 'delete#' do
    include DeviseSupport
    let(:article) { FactoryGirl.create :article,  user: @user }
    let!(:article1) { FactoryGirl.create :article }

    before :each do
      sign_in_user
      article.save
    end

    it { expect{ delete(article_path(article)) }.to change(Article, :count).by(-1) }
    it { expect{ delete(article_path(article1)) }.to change(Article, :count).by(0) }
  end
end