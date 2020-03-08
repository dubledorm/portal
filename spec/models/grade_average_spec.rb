require 'rails_helper'

RSpec.describe GradeAverage, type: :model do
  describe 'factory' do
    let!(:grade_average) {FactoryGirl.create :grade_average}

    # Factories
    it { expect(grade_average).to be_valid }

    # Validations
    it { should validate_presence_of(:grade_type) }
    it { expect(FactoryGirl.build(:grade_average, grade_value: Grade::GRADE_RANGE + 1)).to be_invalid }
    it { expect(FactoryGirl.build(:grade_average, grade_value: Grade::GRADE_RANGE)).to be_valid }
    it { expect(FactoryGirl.build(:grade_average, grade_value: 0)).to be_invalid }
    it { expect(FactoryGirl.build(:grade_average, grade_value: -1)).to be_invalid }
    it { expect(FactoryGirl.build(:grade_average, grade_value: 0.1)).to be_invalid }

    it { should belong_to(:object) }
  end

  describe 'object uniqness' do
    let!(:blog) {FactoryGirl.create :blog}
    let!(:blog1) {FactoryGirl.create :blog}

    context 'when already exists grade the same type by the same user' do
      let!(:grade_average) {FactoryGirl.create :grade_average, object: blog }

      it { expect(FactoryGirl.build(:grade_average, object: blog)).to be_invalid }
      it { expect(FactoryGirl.build(:grade_average, grade_type: 'politeness', object: blog)).to be_valid }
      it { expect(FactoryGirl.build(:grade_average, object: blog1)).to be_valid }
    end
  end
end
