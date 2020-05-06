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
        get(user_cabinet_path)
        expect(response).to have_http_status(200)
      end
    end
  end


  describe 'update#' do
    include DeviseSupport

    before :each do
      sign_in_user
    end

    context 'when update main_description and user_parameter does not exist' do
      subject { put(user_cabinet_path(user: { main_description: 'Какое-то значение'})) }

      it { expect{ subject }.to change(UserParameter, :count).by(1) }

      it 'should set main_description' do
        subject
        expect(@user.main_description).to eq('Какое-то значение')
      end
    end

    context 'when update main_description and user_parameter exists' do
      before :each do
        @user.create_user_parameter(description: 'Другое значение')
      end
      subject { put(user_cabinet_path(user: { main_description: 'Какое-то значение'})) }

      it { expect{ subject }.to change(UserParameter, :count).by(0) }
      it 'should set main_description' do
        subject
        expect(@user.main_description).to eq('Какое-то значение')
      end
    end
  end
end