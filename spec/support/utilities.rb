def full_title(page_title)
  	
    base_title = "Заявки на перевозки"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-danger', text: message)
  end
end

def valid_signin(user)
    fill_in "Электронная почта",    with: user.email
    fill_in "Пароль", with: user.password.upcase
    click_button "Вход"
end

def sign_in(user, options={})
  if options[:no_capybara]
    # Sign in when not using Capybara.
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
  else
    visit signin_path
    fill_in "Электронная почта",    with: user.email
    fill_in "Пароль", with: user.password
    click_button "Вход"
  end
end