require 'rails_helper'
require 'support/devise_support'


RSpec.describe GradesController, :type => :controller do

  context 'when authentication does not need' do

    context 'index#' do
      let!(:grade) { FactoryGirl.create :grade }

      before :each do
        get :index, params: { grade_type: grade.grade_type, object: { object_id: grade.object_id, object_type: grade.object_type } }
      end

      it { expect(response).to have_http_status(200) }
      it { expect(assigns(:collection).count).to eq(1) }
    end

    context 'index# bad request' do
      let!(:grade) { FactoryGirl.create :grade }

      before :each do
        get :index
      end

      it { expect(response).to have_http_status(400) }
    end

    context 'show#' do
      let!(:grade) { FactoryGirl.create :grade }

      before :each do
        get :show, params: { id: grade.to_param }
      end

      it { expect(response).to render_template(:show) }
      it { expect(assigns(:resource).id).to eq(grade.id) }
    end

    # context 'delete#' do
    #   let!(:user1) { FactoryGirl.create :user }
    #   let!(:grade1) { FactoryGirl.create :grade, user: user1 }
    #   subject { delete :destroy, params: { id: grade1.id, user_id: user1.id }  }
    #
    #   before :each do
    #     subject
    #   end
    #
    #   it { expect{ subject }.to change(Grade, :count).by(0) }
    #   it 'should return 403' do
    #     expect(response).to have_http_status(403)
    #   end
    # end
    #
    # context 'update#' do
    #   let!(:grade1) { FactoryGirl.create :grade }
    #   let!(:valid_attributes) { { grade_value: Grade::GRADE_RANGE - 1 } }
    #   subject { put :update, params: { id: grade1.id, user_id: 0, grade: valid_attributes } }
    #
    #   before :each do
    #     subject
    #   end
    #
    #   it { expect(response).to have_http_status(403) }
    # end
  end

  # context 'when need authentication' do
  #   include DeviseSupport
  #   let!(:user1) { FactoryGirl.create :user }
  #   let(:grade) { FactoryGirl.build :grade, object: user1 }
  #   let!(:grade1) { FactoryGirl.create :grade, user: user1 }
  #
  #   before :each do
  #     sign_in_user
  #   end
  #
  #   context 'new#' do
  #     subject { get :new, params: { user_id: @user.id,
  #                                   grade_type: :quality,
  #                                   object: { object_id: user1.id,
  #                                             object_type: 'User' }  }  }
  #     before :each do
  #       subject
  #     end
  #
  #     it { expect(response).to have_http_status(200) }
  #     it { expect(assigns(:resource)).to_not eq(nil) }
  #     it { expect(response).to render_template(:new) }
  #   end
  #
  #   context 'create#' do
  #     subject { post :create, params: { user_id: @user.id, grade: grade.attributes }  }
  #
  #     it { expect{ subject }.to change(Grade, :count).by(1) }
  #     it 'should return 302' do
  #       subject
  #       expect(response).to have_http_status(302)
  #     end
  #   end
  #
  #   context 'edit#' do
  #     let(:grade) { FactoryGirl.create :grade, user_id: @user.id }
  #     subject { get :edit, params: { id: grade.id, user_id: @user.id }  }
  #     before :each do
  #       subject
  #     end
  #
  #     it { expect(response).to have_http_status(200) }
  #     it { expect(assigns(:resource)).to_not eq(nil) }
  #     it { expect(response).to render_template(:edit) }
  #   end
  #
  #   context 'update#' do
  #     let!(:valid_attributes) { { grade_value: Grade::GRADE_RANGE - 1 } }
  #     let(:grade) { FactoryGirl.create :grade, user_id: @user.id, object: user1  }
  #     subject { put :update, params: { id: grade.id, user_id: @user.id, grade: valid_attributes }  }
  #
  #     before :each do
  #       subject
  #     end
  #
  #     it { expect(response).to have_http_status(302) }
  #     it 'should change grade' do
  #       grade.reload
  #       expect(grade.grade_value).to eq(Grade::GRADE_RANGE - 1)
  #     end
  #   end
  #
  #   context 'forbidden update#' do
  #     let!(:valid_attributes) { { grade_value: Grade::GRADE_RANGE - 1 } }
  #     subject { put :update, params: { id: grade1.id, user_id: @user.id, grade: valid_attributes } }
  #
  #     before :each do
  #       subject
  #     end
  #
  #     it { expect(response).to have_http_status(403) }
  #   end
  # end
  #
  #
  # context 'delete#' do
  #   include DeviseSupport
  #   let!(:user) { FactoryGirl.create :user }
  #   let!(:grade) { FactoryGirl.create :grade, user_id: user.id }
  #   subject { delete :destroy, params: { id: grade.id, user_id: user.id }  }
  #
  #   before :each do
  #     sign_in(user)
  #   end
  #
  #   it { expect{ subject }.to change(Grade, :count).by(-1) }
  #   it 'should return 204' do
  #     subject
  #     expect(response).to have_http_status(204)
  #   end
  # end
  #
  # context 'forbidden delete#' do
  #   include DeviseSupport
  #   let!(:user) { FactoryGirl.create :user }
  #   let!(:user1) { FactoryGirl.create :user }
  #   let!(:grade1) { FactoryGirl.create :grade, user: user1 }
  #   subject { delete :destroy, params: { id: grade1.id, user_id: user1.id }  }
  #
  #   before :each do
  #     sign_in(user)
  #   end
  #
  #   it { expect{ subject }.to change(Grade, :count).by(0) }
  #   it 'should retirn 403' do
  #     subject
  #     expect(response).to have_http_status(403)
  #   end
  # end
end