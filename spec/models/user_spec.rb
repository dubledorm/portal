require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'factory' do
    let!(:user) {FactoryGirl.create :user}

    # Factories
    it { expect(user).to be_valid }

    # Validations
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }

    it { should have_many(:tags_on_objects) }
    it { should have_many(:tags) }
  end

  describe 'cascade delete of services' do
    let!(:user) {FactoryGirl.create :user}
    let!(:service1) {FactoryGirl.create :service, user: user}
    let!(:service2) {FactoryGirl.create :service, user: user}

    it { expect{ user.destroy }.to change(Service, :count).by(-2) }
  end
end
