require 'rails_helper'

RSpec.describe Grade::RecalculateService do
  let!(:user) {FactoryGirl.create :user}
  let!(:user1) {FactoryGirl.create :user}

  it { expect(GradeAverage.all.count).to eq(0) }


  context 'when grade_averages do not exist' do
    let!(:grade1) {FactoryGirl.create :grade,
                                      user: user1, object: user,
                                      grade_type: :quality, grade_value: Grade::GRADE_RANGE}

    it { expect{ described_class.new(grade1).call }.to change(GradeAverage, :count).by(1) }
  end


  context 'when one grade_average already exists' do
    let!(:grade1) { FactoryGirl.create :grade,
                                      user: user1, object: user,
                                      grade_type: :quality, grade_value: Grade::GRADE_RANGE}
    before :each do
      described_class.new(grade1).call
    end

    it 'should not create new grade_average' do
      grade2 = FactoryGirl.create(:grade, user: user,
                                  object: user, grade_type: :quality, grade_value: 1)

      expect{ described_class.new(grade2).call }.to change(GradeAverage, :count).by(0)
      expect(GradeAverage.all.first.grade_value).to eq((Grade::GRADE_RANGE + 1) / 2)
      expect(GradeAverage.all.first.grade_count).to eq(2)
    end

    it 'should create new grade_average' do
      grade2 = FactoryGirl.create(:grade, user: user,
                                  object: user, grade_type: :politeness, grade_value: 1)

      expect{ described_class.new(grade2).call }.to change(GradeAverage, :count).by(1)
    end
  end
end