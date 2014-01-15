require 'spec_helper'

describe "Авторизация" do

  subject { page }

  describe "страница входа" do
    before { visit signin_path }

    it { should have_content('Вход') }
    it { should have_title('Вход') }
  end

  describe "вход" do
    before { visit signin_path }

    describe "с невалидными данными" do
      before { click_button "Вход" }

      it { should have_title('Вход') }
      it { should have_error_message('неверные') }

      describe "после посещения другой страницы" do
        before { click_link "Заявки" }
        it { should_not have_error_message('неверные') }
      end
    end

    describe "с валидными данными" do
      let(:user) { FactoryGirl.create(:user) }
      before { valid_signin(user) }

      it { should have_title(user.name) }
      it { should have_link('Профиль',     href: user_path(user)) }
      it { should have_link('Выход',    href: signout_path) }
      it { should_not have_link('Вход', href: signin_path) }

      describe "с последующим выходом" do
        before { click_link "Выход" }
        it { should have_link('Вход') }
      end
    end
  end
end