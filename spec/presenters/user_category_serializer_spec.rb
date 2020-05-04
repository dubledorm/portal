require 'rails_helper'

TEST_JSON = '[{"name":"Anim","title":"Аниматоры","included":true},{"name":"Birthday","title":"День рождения","included":true}]'
TEST_WITH_OFF_LINE = '[{"name":"Anim","title":"Аниматоры","included":true},{"name":"FalseBirthday","title":"Выключенный День рождения","included":false},{"name":"Birthday","title":"День рождения","included":true}]'
ERROR_TEST_JSON = '{"name":"Anim","title":"Аниматоры","included":true},{"name":"Birthday","title":"День рождения","included":true}]'
EMPTY_TEST_JSON = '[]'

RSpec.describe UserCategorySerializer do
  let!(:user) {FactoryGirl.create :user}

  context 'when categories do not exist' do
    it { expect(described_class.new(user).attributes).to eq({categories: []}) }
  end

  context 'when one category exists and not included' do
    let!(:category1) {FactoryGirl.create :tag_category, name: 'category1', title: 'Категория1' }

    it { expect(described_class.new(user).attributes).to eq({ categories: [{ name: 'category1',
                                                                                                   title: 'Категория1',
                                                                                                   included: false }] }) }
  end

  context 'when two category exists and one of them included' do
    let!(:category1) {FactoryGirl.create :tag_category, name: 'category1', title: 'Категория1' }
    let!(:category2) {FactoryGirl.create :tag_category, name: 'category2', title: 'Категория2' }

    before :each do
      user.add_category('category2')
    end

    it { expect(described_class.new(user).attributes).to eq({ categories: [{ name: 'category1',
                                                                             title: 'Категория1',
                                                                             included: false },
                                                                           { name: 'category2',
                                                                             title: 'Категория2',
                                                                             included: true }] }) }
    it { ap(described_class.new(user).serializable_hash) }
  end

  describe 'parseString' do

    it { expect{ described_class.parse_string('') }.to raise_error(UserCategorySerializer::UCSerializerError)  }
    it { expect{ described_class.parse_string(ERROR_TEST_JSON) }.to raise_error(UserCategorySerializer::UCSerializerError)  }

    it { expect{ described_class.parse_string(EMPTY_TEST_JSON) }.to_not raise_error }
    it { expect{ described_class.parse_string(TEST_JSON) }.to_not raise_error }

    it { expect(described_class.parse_string(EMPTY_TEST_JSON)).to eq([])}
    it { expect(described_class.parse_string(TEST_JSON)).to eq([{name: 'Anim', title: 'Аниматоры', included: true},
                                                               {name: 'Birthday', title: 'День рождения', included: true}])}
    it { expect(described_class.parse_string(TEST_WITH_OFF_LINE)).to eq([{name: 'Anim', title: 'Аниматоры', included: true},
                                                               {name: 'Birthday', title: 'День рождения', included: true}])}
  end
end