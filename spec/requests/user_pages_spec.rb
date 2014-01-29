require 'spec_helper'

describe "Страницы пользователей" do

  subject { page }

  describe "список" do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      sign_in user
      visit users_path
    end

    it { should have_title('Все пользователи') }
    it { should have_content('Все пользователи') }

    describe "Пагинация" do

      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }

      it "перечисление каждого пользователя" do
        User.paginate(page: 1, :per_page => 5).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end

    describe "ссылка на удаление" do

      it { should_not have_link('удалить') }

      describe "как админ" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('удалить', href: user_path(User.first)) }
        it "должен быть в состоянии удалить другого пользователя" do
          expect do
            click_link('удалить', match: :first)
          end.to change(User, :count).by(-1)
        end
        it { should_not have_link('удалить', href: user_path(admin)) }
      end
    end
  end

  describe "страница профиля" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

  describe "редактирование" do
    let(:user) { FactoryGirl.create(:user) }
    before do 
      sign_in user
      visit edit_user_path(user)
    end 

    describe "страница" do
      it { should have_content("Обновление профиля") }
      it { should have_title("Редактирование пользователя") }
      it { should have_link('Сменить аватар', href="http://gravatar.com/emails") }
    end

    describe "с некорректной инфой" do
      before { click_button "Сохранить изменения" }

      it { should have_content('error') }
    end

    describe "с корректной инфой" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Имя",                          with: new_name
        fill_in "Электронная почта",            with: new_email
        fill_in "Пароль",                       with: user.password
        fill_in "Подтверждение пароля",         with: user.password
        click_button "Сохранить изменения"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Выход', href: signout_path) }
      specify { expect(user.reload.name).to  eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end

    describe "скрытые аттрибуты" do
      let(:params) do
        { user: { admin: true, password: user.password,
                  password_confirmation: user.password } }
      end
      before do
        sign_in user, no_capybara: true
        patch user_path(user), params
      end
      specify { expect(user.reload).not_to be_admin }
    end
  end
end