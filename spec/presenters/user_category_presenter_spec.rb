require 'rails_helper'

TEST_JSON = '[{"name":"Anim","title":"Аниматоры","included":true},{"name":"Birthday","title":"День рождения","included":true}]'
TEST_WITH_OFF_LINE = '[{"name":"Anim","title":"Аниматоры","included":true},{"name":"FalseBirthday","title":"Выключенный День рождения","included":false},{"name":"Birthday","title":"День рождения","included":true}]'
ERROR_TEST_JSON = '{"name":"Anim","title":"Аниматоры","included":true},{"name":"Birthday","title":"День рождения","included":true}]'
EMPTY_TEST_JSON = '[]'


RSpec.describe UserCategoryPresenter do
  let!(:user) {FactoryGirl.create :user}

  describe 'from_user' do
    context 'when categories do not exist' do
      it { expect(described_class.new.from_user(user).categories).to eq([]) }
    end

    context 'when one category exists and not included' do
      let!(:category1) {FactoryGirl.create :tag_category, name: 'category1', title: 'Категория1' }

      it {  expect(described_class.new.from_user(user).categories).to eq([]) }
    end

    context 'when one category exists and included' do
      let!(:category1) {FactoryGirl.create :tag_category, name: 'category1', title: 'Категория1' }

      before :each do
        user.add_category('category1')
      end

      it { expect(described_class.new.from_user(user).categories).to eq([{ name: 'category1',
                                                                           title: 'Категория1',
                                                                           included: true }] ) }
    end
  end


  describe 'from_json_string' do

    it { expect{ described_class.new.from_json_string('') }.to raise_error(UserCategoryPresenter::UCPresenterError)   }

    it { expect{ described_class.new.from_json_string(ERROR_TEST_JSON) }.to raise_error(UserCategoryPresenter::UCPresenterError)  }

    it { expect{ described_class.new.from_json_string(EMPTY_TEST_JSON) }.to_not raise_error }
    it { expect{ described_class.new.from_json_string(TEST_JSON) }.to_not raise_error }

    it { expect(described_class.new.from_json_string(EMPTY_TEST_JSON).categories).to eq([])}

    it { expect(described_class.new.from_json_string(TEST_JSON).categories).to eq([{name: 'Anim', title: 'Аниматоры', included: true},
                                                                                   {name: 'Birthday', title: 'День рождения', included: true}])}

    it { expect(described_class.new.from_json_string(TEST_WITH_OFF_LINE).categories).to eq([{name: 'Anim', title: 'Аниматоры', included: true},
                                                                                            {name: 'Birthday', title: 'День рождения', included: true}])}
  end


  describe 'to_json' do
    context 'when categories do not exist' do
      it { expect(described_class.new.from_user(user).to_json).to eq('[]') }
    end

    context 'when one category exists and not included' do
      let!(:category1) {FactoryGirl.create :tag_category, name: 'category1', title: 'Категория1' }

      it { expect(described_class.new.from_user(user).to_json).to eq('[{"name":"category1","title":"Категория1","included":false}]') }
    end

    context 'when two category exists and one of them included' do
      let!(:category2) {FactoryGirl.create :tag_category, name: 'category2', title: 'Категория2' }
      let!(:category1) {FactoryGirl.create :tag_category, name: 'category1', title: 'Категория1' }

      before :each do
        user.add_category('category2')
      end

      it { expect(described_class.new.from_user(user).to_json).to eq('[{"name":"category1","title":"Категория1","included":false},' +
                                                                     '{"name":"category2","title":"Категория2","included":true}]') }
      it { ap(described_class.new.from_user(user).to_json) }
    end
  end
end