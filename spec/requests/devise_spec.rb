require 'rails_helper'
require 'support/devise_support'


RSpec.describe 'Device', type: :request do

  describe 'Sessions' do
    it "signs user in and out" do
      user = User.create!(email: "user@example.org", password: "very-secret")
      user.confirm

      sign_in user
      get authenticated_root_path
      expect(controller.current_user).to eq(user)

      sign_out user
      get authenticated_root_path
      expect(controller.current_user).to be_nil
    end

    context 'when user unconfirmed' do
      it 'should sign in if time does not elapsed' do
        user = User.create!(email: "user@example.org", password: "very-secret")

        ap(Devise.allow_unconfirmed_access_for)
        allow(Devise).to receive(:allow_unconfirmed_access_for).and_return( 3.days )
        ap(Devise.allow_unconfirmed_access_for)

        Timecop.travel(Date.today + Devise.allow_unconfirmed_access_for - 1) do
          sign_in user
          get authenticated_root_path
          expect(controller.current_user).to eq(user)
        end
      end


      it "should not to signs user in" do
        user = User.create!(email: "user@example.org", password: "very-secret")

        ap(Devise.allow_unconfirmed_access_for)
        allow(Devise).to receive(:allow_unconfirmed_access_for).and_return( 3.days )
        ap(Devise.allow_unconfirmed_access_for)

        Timecop.travel(Date.today + Devise.allow_unconfirmed_access_for + 1) do
          sign_in user
          get authenticated_root_path
          expect(controller.class).to eq(Devise::FailureApp)
        end
      end
    end
  end

  describe 'Check devise_support' do
    include DeviseSupport

    it "signs user in and out" do
      sign_in_user

      get authenticated_root_path
      expect(controller.current_user).to eq(@user)

      sign_out_user
      get authenticated_root_path
      expect(controller.current_user).to be_nil
    end
  end
end