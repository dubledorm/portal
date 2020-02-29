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
    it { should have_many(:galleries) }
  end

  describe 'cascade delete of services' do
    let!(:user) {FactoryGirl.create :user}
    let!(:service1) {FactoryGirl.create :service, user: user}
    let!(:service2) {FactoryGirl.create :service, user: user}

    it { expect{ user.destroy }.to change(Service, :count).by(-2) }
  end

  describe 'taggable' do
    let!(:user1) {FactoryGirl.create :user}
    let!(:user2) {FactoryGirl.create :user}
    let!(:tag1) {FactoryGirl.create :tag, name: 'tag1'}
    let!(:tag2) {FactoryGirl.create :tag, name: 'tag2'}

    before :each do
      user1.tags << tag1
      user2.tags << tag2
      user2.tags << tag1
    end

    it { expect(Tag.count).to eq(2) }
    it { expect(user1.tags.count).to eq(1) }
    it { expect(User.by_tag('tag1').count).to eq(2) }
    it { expect{ user1.add_tag('tag3').to change(Tag, :count).by(1) }}
    it { expect{ user1.add_tag('tag3').to change(user1.tags, :count).by(1) }}

    it { expect{ user1.add_tag('tag2').to change(Tag, :count).by(0) }}
    it { expect{ user1.add_tag('tag2').to change(user1.tags, :count).by(1) }}

    it { expect{ user1.add_tag('tag1').to change(Tag, :count).by(0) }}
    it { expect{ user1.add_tag('tag1').to change(user1.tags, :count).by(0) }}

    it 'should return all tags by name' do
      user1.add_tag('tag4')
      user1.add_tag('tag5')
      ap(user1.tags_names)

      expect(user1.tags_names).to eq('tag1, tag4, tag5')
    end

    it 'should return all tags by title' do
      user1.add_tag('tag4', 'Тэг 4')
      user1.add_tag('tag5', 'Тэг 5')
      ap(user1.tags_titles)

      expect(user1.tags_titles).to eq(', Тэг 4, Тэг 5')
    end

    it 'should delete tag by name' do
      user1.delete_tag('tag1')

      expect(user1.tags_names).to eq('')
    end
  end

  describe 'taggable delete' do
    let!(:user1) {FactoryGirl.create :user}
    let!(:user2) {FactoryGirl.create :user}
    let!(:tag1) {FactoryGirl.create :tag, name: 'tag1'}
    let!(:tag2) {FactoryGirl.create :tag, name: 'tag2'}

    before :each do
      user1.tags << tag1
      user2.tags << tag2
      user1.tags << tag2
    end

    it { expect{ user1.delete_tag('tag1') }.to change(user1.tags, :count).by(-1) }
    it { expect{ user1.delete_tag('tag1') }.to change(Tag, :count).by(-1) }

    it { expect{ user2.delete_tag('tag2') }.to change(user2.tags, :count).by(-1) }
    it { expect{ user2.delete_tag('tag2') }.to change(Tag, :count).by(0) }
  end
end
