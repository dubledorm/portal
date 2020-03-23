require 'rails_helper'

RSpec.describe Grade, type: :model do
  describe 'factory' do
    let!(:grade) {FactoryGirl.create :grade}
    let!(:grade1) {FactoryGirl.create :grade_without_value}


    # Factories
    it { expect(grade).to be_valid }
    it { expect(grade1).to be_valid }

    # Validations
    it { should validate_presence_of(:grade_type) }
    it { expect(FactoryGirl.build(:grade, grade_value: Grade::GRADE_RANGE + 1)).to be_invalid }
    it { expect(FactoryGirl.build(:grade, grade_value: Grade::GRADE_RANGE)).to be_valid }
    it { expect(FactoryGirl.build(:grade, grade_value: 0)).to be_invalid }
    it { expect(FactoryGirl.build(:grade, grade_value: -1)).to be_invalid }
    it { expect(FactoryGirl.build(:grade, grade_value: 0.1)).to be_invalid }

    it { should belong_to(:user) }
    it { should belong_to(:object) }
  end

  describe 'user uniqness' do
    let!(:user) {FactoryGirl.create :user}
    let!(:user1) {FactoryGirl.create :user}
    let!(:blog) {FactoryGirl.create :blog}
    let!(:blog1) {FactoryGirl.create :blog}

    context 'when already exists grade the same type by the same user' do
      let!(:grade) {FactoryGirl.create :grade, user: user, object: blog }

      it { expect(FactoryGirl.build(:grade, user: user, object: blog)).to be_invalid }
      it { expect(FactoryGirl.build(:grade, grade_type: 'politeness', user: user, object: blog)).to be_valid }
      it { expect(FactoryGirl.build(:grade, user: user, object: blog1)).to be_valid }
      it { expect(FactoryGirl.build(:grade, user: user1, object: blog)).to be_valid }
    end
  end

  describe 'scope#' do
    let!(:grade) {FactoryGirl.create :grade, grade_type: :quality }
    let!(:grade1) {FactoryGirl.create :grade, grade_type: :interestingness }
    let!(:grade2) {FactoryGirl.create :grade, grade_type: :politeness }

    it { expect(Grade.by_grade_type(:quality).count).to eq(1) }
    it { expect(Grade.by_grade_type(:interestingness).first).to eq(grade1) }
    it { expect(Grade.by_object(grade2.object_id, grade2.object_type).first).to eq(grade2) }
    it { expect(Grade.by_object(grade2.object_id, grade2.object_type).count).to eq(1) }
  end
end
