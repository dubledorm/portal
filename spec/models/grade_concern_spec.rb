require 'rails_helper'

RSpec.describe GradeConcern, type: :model do
  describe 'average_grade' do
    let!(:user) {FactoryGirl.create :user}
    let!(:user1) {FactoryGirl.create :user}
    let!(:user2) {FactoryGirl.create :user}
    let!(:user3) {FactoryGirl.create :user}
    let!(:user4) {FactoryGirl.create :user}


    context 'when only one grade exists' do
      let!(:grade) {FactoryGirl.create :grade,
                                       user: user1, object: user,
                                       grade_type: :quality, grade_value: Grade::GRADE_RANGE}

      it { expect(user.grades.count).to eq(1) }
      it { expect(user.grades.by_grade_type(:quality).count).to eq(1) }
      it { expect(user.grades.by_grade_type('interestingness').count).to eq(0) }
      it { expect(user.average_grade(:quality)).to eq({ average_grade: Grade::GRADE_RANGE, count: 1 }) }
      it { expect(user.average_grade('interestingness')).to eq({ average_grade: nil, count: 0 }) }
    end

    context 'when many grades exist' do
      let!(:grade1) {FactoryGirl.create :grade,
                                       user: user1, object: user,
                                       grade_type: :quality, grade_value: Grade::GRADE_RANGE}
      let!(:grade2) {FactoryGirl.create :grade,
                                       user: user2, object: user,
                                       grade_type: :quality, grade_value: Grade::GRADE_RANGE}
      let!(:grade3) {FactoryGirl.create :grade,
                                       user: user3, object: user,
                                       grade_type: :quality, grade_value: 1}
      let!(:grade4) {FactoryGirl.create :grade,
                                       user: user4, object: user,
                                       grade_type: :quality, grade_value: 1}
      let!(:grade5) {FactoryGirl.create :grade,
                                        user: user4, object: user,
                                        grade_type: :interestingness, grade_value: 1}



      it { expect(user.grades.count).to eq(5) }
      it { expect(user.grades.by_grade_type(:quality).count).to eq(4) }
      it { expect(user.grades.by_grade_type('interestingness').count).to eq(1) }
      it { expect(user.average_grade(:quality)).to eq({ average_grade: (Grade::GRADE_RANGE * 2 + 2) / 4, count: 4 }) }
      it { expect(user.average_grade('interestingness')).to eq({ average_grade: 1, count: 1 }) }
    end
  end
end
