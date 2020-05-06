module FeatureHelper
  def admin_login
    init_admin_defaults
    come_in(@admin)
  end

  def manager_login
    init_user_defaults
    come_in(@user)
  end

  def user_login
    init_user_defaults
    visit new_user_session_path
    fill_in I18n.t('activerecord.attributes.user.email'), with: @user.email
    fill_in I18n.t('activerecord.attributes.user.password'), with: @user.password

    click_button I18n.t('forms.login.login_word')
  end

  def init_admin_defaults
    @admin ||= FactoryGirl.create(:admin_user, email: 'admin@example.com', password: 'password')
  end

  def init_user_defaults
    @user ||= FactoryGirl.create(:user, email: 'user@example.com', password: 'password')
  end
end