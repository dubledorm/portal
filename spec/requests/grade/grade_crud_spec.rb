require 'rails_helper'
require 'support/devise_support'
require 'support/shared/request_shared_examples'


RSpec.describe 'Grade', type: :request do

  describe 'index#' do
    let!(:grade1) {FactoryGirl.create :grade}

    context 'when bad request' do
      it_should_behave_like 'get response 400' do
        subject { get(grades_path()) }
      end

      it_should_behave_like 'get response 400' do
        subject { get(grades_path(grade_type: grade1.grade_type)) }
      end

      it_should_behave_like 'get response 400' do
        subject { get(grades_path(grade_type: grade1.grade_type, object: {object_id: grade1.object_id})) }
      end

      it_should_behave_like 'get response 400' do
        subject { get(grades_path(grade_type: grade1.grade_type, object: {object_type: grade1.object_type})) }
      end
    end

    context 'when good requets' do
      it 'should return record' do
        get(grades_path(grade_type: grade1.grade_type, object: {object_id: grade1.object_id, object_type: grade1.object_type}))
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'create#' do
    include DeviseSupport
    let!(:user1) { FactoryGirl.create :user }
    let(:grade) { FactoryGirl.build :grade, object: user1 }
    let(:subject) { post(grades_path(), params: { grade: grade.attributes }) }

    before :each do
      sign_in_user
    end

    it { expect{ post(grades_path(), params: { grade: grade.attributes }) }.to change(Grade, :count).by(1) }
    it { expect{ subject }.to change(GradeAverage, :count).by(1) }
  end

  describe 'update#' do
    include DeviseSupport
    let!(:user1) { FactoryGirl.create :user }

    context 'when we are owner of the record' do
      let(:grade) { FactoryGirl.create :grade, object: user1, user: @user }
      let(:subject) { put(grade_path(grade), params: { grade: { grade_value: 1 } }) }

      before :each do
        sign_in_user
        subject
        grade.reload
      end

      it { expect(grade.grade_value).to eq(1) }
      it { expect(GradeAverage.first.grade_value).to eq(1) }
    end

    context 'when we are not owner of the record' do
      let!(:grade) { FactoryGirl.create :grade, object: user1 }

      before :each do
        sign_in_user
      end

      it_should_behave_like 'get response 403' do
        subject { put(grade_path(grade), params: { grade: { grade_value: 1 } })  }
      end
    end
  end

  describe 'delete#' do
    include DeviseSupport
    let!(:user1) { FactoryGirl.create :user }
    let(:grade) { FactoryGirl.create :grade, object: user1, user: @user }
    let!(:grade1) { FactoryGirl.create :grade, object: user1 }

    before :each do
      sign_in_user
      grade.save
    end

    it { expect{ delete(grade_path(grade)) }.to change(Grade, :count).by(-1) }
    it { expect{ delete(grade_path(grade1)) }.to change(Grade, :count).by(0) }
  end
end