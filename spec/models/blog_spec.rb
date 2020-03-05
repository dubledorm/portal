require 'rails_helper'

RSpec.describe Blog, type: :model do
  describe 'factory' do
    let!(:blog) {FactoryGirl.create :blog}

    # Factories
    it { expect(blog).to be_valid }

    # Validations
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:post_type) }
    it { should validate_presence_of(:title) }

    it { should have_many(:tags) }
    it { should belong_to(:gallery) }
    it { should belong_to(:user) }
  end
end
