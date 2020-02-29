require 'rails_helper'

RSpec.describe Picture, type: :model do
  describe 'factory' do
    let!(:picture) {FactoryGirl.create :picture}

    # Factories
   it { expect(picture).to be_valid }

   it { should belong_to(:gallery) }
   it { should have_one(:user) }

   it { should validate_presence_of(:state) }
  end
end
