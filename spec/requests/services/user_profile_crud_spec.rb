require 'rails_helper'
require 'support/devise_support'
require 'support/shared/request_shared_examples'


RSpec.describe 'Service', type: :request do
  describe 'delete#' do
    include DeviseSupport
    let!(:user1) { FactoryGirl.create :user }
    let(:service) { FactoryGirl.create :service, user: @user }
    let!(:service1) { FactoryGirl.create :service, user: user1 }

    before :each do
      sign_in_user
      service.save
    end

    it { expect{ delete(user_profile_service_path(id: service.id)) }.to change(Service, :count).by(-1) }
    it { expect{ delete(user_profile_service_path(id: service1.id)) }.to change(Grade, :count).by(0) }
    it { expect{ delete(user_profile_service_path(id: service1.id)) }.to change(Grade, :count).by(0) }
  end
end