require 'rails_helper'

RSpec.describe UserParameter, type: :model do
  describe 'factory' do
    let!(:user_parameter) {FactoryGirl.create :user_parameter}

    # Factories
    it { expect(user_parameter).to be_valid }


    it { should belong_to(:user) }
  end
end
