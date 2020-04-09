require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'factory' do
    let!(:tag) {FactoryGirl.create :tag}

    # Factories
    it { expect(tag).to be_valid }

    # Validations
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:tag_type) }

    it { should have_many(:tags_on_objects) }
    it { should have_many(:users) }
    it { should have_many(:blogs) }
  end

  describe 'tag_type' do
    it { expect(FactoryGirl.build(:tag, name: 'name1', tag_type: 'ordinal')).to be_valid }
    it { expect(FactoryGirl.build(:tag, name: 'name1', tag_type: 'ordinal_xxxxx')).to be_invalid }
  end

  describe 'uniqness name' do
    let!(:tag) {FactoryGirl.create :tag}

    it { expect(FactoryGirl.build(:tag, name: tag.name, tag_type: tag.tag_type)).to be_invalid }
    it { expect(FactoryGirl.build(:tag, name: tag.name, tag_type: 'category')).to be_valid }
  end

  describe 'scope' do
    let!(:tag1) {FactoryGirl.create :tag}
    let!(:tag2) {FactoryGirl.create :tag}
    let!(:user) {FactoryGirl.create :user}
    let!(:user1) {FactoryGirl.create :user}


    before :each do
      user.add_tag(tag2.name)
      user1.add_tag('new_name')
    end

    it { expect(Tag.count).to eq(3) }
    it { expect(Tag.by_user(user).count).to eq(1) }
    it { expect(Tag.by_user(user).first).to eq(tag2) }
    it { expect(Tag.by_user(user1).first.name).to eq('new_name') }

  end

  describe 'has_tag' do
    let!(:user) { FactoryGirl.create :user }
    let!(:tag1) { FactoryGirl.create :tag, name: 'tag1' }
    let!(:tag2) { FactoryGirl.create :tag, name: 'tag2' }
    let!(:tag3) { FactoryGirl.create :tag, name: 'tag3' }

    before :each do
      user.add_tag('tag1')
      user.add_tag('tag3')
    end

    it { expect(user.has_tag?('tag1')).to eq(true) }
    it { expect(user.has_tag?('tag2')).to eq(false) }
    it { expect(user.has_tag?('abrakadabra')).to eq(false) }

  end
end
