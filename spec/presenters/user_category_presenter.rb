require 'rails_helper'

RSpec.describe UserCategoryPresenter do
  let!(:user) {FactoryGirl.create :user}

  context 'when categories do not exist' do
    it { expect(described_class.new(user, ActionView::Base.new).attributes).to eq({categories: []}) }
  end

  context 'when one category exists and not included' do
    let!(:category1) {FactoryGirl.create :tag_category, name: 'category1', title: 'Категория1' }

    it { expect(described_class.new(user, ActionView::Base.new).attributes).to eq({ categories: [{ name: 'category1',
                                                                                                   title: 'Категория1',
                                                                                                   included: false }] }) }
  end

  context 'when two category exists and one of them included' do
    let!(:category1) {FactoryGirl.create :tag_category, name: 'category1', title: 'Категория1' }
    let!(:category2) {FactoryGirl.create :tag_category, name: 'category2', title: 'Категория2' }

    before :each do
      user.add_category('category2')
    end

    it { expect(described_class.new(user, ActionView::Base.new).attributes).to eq({ categories: [{ name: 'category1',
                                                                                                   title: 'Категория1',
                                                                                                   included: false },
                                                                                                 { name: 'category2',
                                                                                                   title: 'Категория2',
                                                                                                   included: true }] }) }
    it { ap(described_class.new(user, ActionView::Base.new).serializable_hash) }
  end
end