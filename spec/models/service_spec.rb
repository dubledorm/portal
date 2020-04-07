require 'rails_helper'

RSpec.describe Service, type: :model do
  describe 'factory' do
    let!(:service) {FactoryGirl.create :service}

    # Factories
    it { expect(service).to be_valid }

    it { should belong_to(:user) }
  end

  describe 'scope' do
    let!(:service1) {FactoryGirl.create :service, provider: 'vkontakte'}
    let!(:service2) {FactoryGirl.create :service}

    it { expect(Service.by_provider('vkontakte').count).to eq(1) }
    it { expect(Service.by_provider('another').count).to eq(0) }
    it { expect(Service.by_provider('facebook').count).to eq(1) }

    it { expect(Service.by_provider('vkontakte').first).to eq(service1) }
    it { expect(Service.by_provider('facebook').first).to eq(service2) }

  end
end
