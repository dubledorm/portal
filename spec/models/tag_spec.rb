require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'factory' do
    let!(:tag) {FactoryGirl.create :tag}

    # Factories
    it { expect(tag).to be_valid }

    # Validations
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:tag_type) }
  end

  describe 'uniqness name' do
    let!(:tag) {FactoryGirl.create :tag}

    it { expect(FactoryGirl.build(:tag, name: tag.name, tag_type: tag.tag_type)).to be_invalid }
    it { expect(FactoryGirl.build(:tag, name: tag.name, tag_type: tag.tag_type + '_another')).to be_valid }
  end
end
