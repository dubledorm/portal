require 'rails_helper'

RSpec.describe Gallery, type: :model do
  describe 'factory' do
    let!(:gallery) {FactoryGirl.create :gallery}

    # Factories
    it { expect(gallery).to be_valid }

    it { should belong_to(:user) }

    it { should validate_presence_of(:state) }
  end
end
