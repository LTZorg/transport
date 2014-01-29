require 'spec_helper'

describe "Аунтификация" do

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
      before { sign_in user }

      it { should have_title(user.name) }
      it { should have_link('Пользователи',     href: users_path) }
      it { should have_link('Профиль',     href: user_path(user)) }
      it { should have_link('Настройки', href: edit_user_path(user)) }
      it { should have_link('Выход',    href: signout_path) }
      it { should_not have_link('Вход', href: signin_path) }

      describe "с последующим выходом" do
        before { click_link "Выход" }
        it { should have_link('Вход') }
      end
    end
  end

  describe "авторизация" do

    describe "для невошедших пользователей" do
      let(:user) { FactoryGirl.create(:user) }

      describe "в Users контроллере" do

        describe "посещение страницы редактирования" do
          before { visit edit_user_path(user) }
          it { should have_title('Вход') }
        end

        describe "принятие изменений" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "посещение страницы списка пользователей" do
          before { visit users_path }
          it { should have_title('Вход') }
        end
      end

      describe "попытка посещения защищенной страницы" do
        before do
          visit edit_user_path(user)
          sign_in user
        end

        describe "после входа" do

          it "перенаправление на страницу запроса" do
            expect(page).to have_title('Редактирование пользователя')
          end
        end
      end

      describe "доступные ссылки" do
        before { visit root_path}

         it { should_not have_link('Пользователи',     href: users_path) }
         it { should_not have_link('Профиль',     href: user_path(user)) }
         it { should_not have_link('Настройки', href: edit_user_path(user)) }
         it { should_not have_link('Выход',    href: signout_path) }
      end
    end

    describe "неправильный пользователь" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user, no_capybara: true }

      describe "submitting a GET request to the Users#edit action" do
        before { get edit_user_path(wrong_user) }
        specify { expect(response.body).not_to match(full_title('Редактирование пользователя')) }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe "submitting a PATCH request to the Users#update action" do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end

    describe "как не админ" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin, no_capybara: true }

      describe "подав DELETE запрос для действия удаления пользователя" do
        before { delete user_path(user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end

    describe "как админ" do
      let(:admin) { FactoryGirl.create(:admin) }

      before { sign_in admin, no_capybara: true }

      describe "подав DELETE запрос для действия удаления себя" do
        before { delete user_path(admin) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end
  end
end