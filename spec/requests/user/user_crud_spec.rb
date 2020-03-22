require 'rails_helper'
require 'support/devise_support'
require 'support/shared/request_shared_examples'


RSpec.describe 'User', type: :request do

  describe 'show#' do
    include DeviseSupport

    context 'when we are owner of the record' do
      let(:user1) { FactoryGirl.create :user}

      before :each do
        sign_in_user
      end

      it 'should return record' do
        get(user_path(@user))
        expect(response).to have_http_status(200)
      end

      it_should_behave_like 'get response 403' do
        subject { get(user_path(user1)) }
      end
    end
  end
end