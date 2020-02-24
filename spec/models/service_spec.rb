require 'rails_helper'

RSpec.describe Service, type: :model do
  describe 'factory' do
    let!(:service) {FactoryGirl.create :service}

    # Factories
    it { expect(service).to be_valid }

    it { should belong_to(:user) }
  end
end
