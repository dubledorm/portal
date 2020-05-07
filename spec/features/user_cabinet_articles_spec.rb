#coding: utf-8
require 'rails_helper'
require 'support/feature_helper'

RSpec.feature 'UserCabinetArticles', js: true do
  include FeatureHelper

  describe 'new#' do
    context 'when not login' do
      it 'should redirect to login page' do
        visit new_user_cabinet_article_path
        expect(current_path).to eq(new_user_session_path)
      end
    end

    context 'when login' do
      before :each do
        user_login
        visit new_user_cabinet_article_path
      end

      it 'should available new_user_cabinet_article_path' do
        expect(current_path).to eq(new_user_cabinet_article_path)
      end

      context 'when new record' do
        it 'should field name available for new' do
          expect(page.has_field?(id: 'article_name')).to be(true)
        end
      end
    end
  end
end