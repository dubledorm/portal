require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'factory' do
    let!(:user) {FactoryGirl.create :user}

    # Factories
    it { expect(user).to be_valid }

    # Validations
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end
end
