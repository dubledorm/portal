require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'factory' do
    let!(:user) { FactoryGirl.create :user_with_categories }

    # Factories
    it { expect(user).to be_valid }

    it { expect(user.ordinal_tags.count).to eq(1)}
    it { expect(user.category_tags.count).to eq(1)}
  end

  describe 'add categories' do
    let!(:user) { FactoryGirl.create :user }
    let!(:tag_category1) { FactoryGirl.create :tag_category, name: 'category1', title: 'Категория 1' }
    let!(:tag_category2) { FactoryGirl.create :tag_category, name: 'category2', title: 'Категория 2' }
    let!(:tag_category3) { FactoryGirl.create :tag_category, name: 'category3', title: 'Категория 3' }

    it { expect{ user.add_category('category1') }.to change(user.category_tags, :count).by(1) }
    it { expect{ user.add_category('category126') }.to raise_error(StandardError) }

    context 'when we add 2 categores' do
      before :each do
        user.add_category('category1')
        user.add_category('category3')
      end

      it { expect(user.category_tags.count).to eq(2) }
      it { expect{ user.delete_category('category1') }.to change(user.category_tags, :count).by(-1) }
      it { expect{ user.delete_category('category1') }.to change(Tag, :count).by(0) }

      it { expect{ user.delete_category('category126') }.to raise_error(StandardError) }

      it { expect(user.has_category?('category1')).to eq(true) }
      it { expect(user.has_category?('category2')).to eq(false) }
      it { expect(user.has_category?('abrakadabra')).to eq(false) }

    end
  end
end