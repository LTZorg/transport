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

  def valid_signin(user)
    fill_in "Электронная почта",    with: user.email
    fill_in "Пароль", with: user.password.upcase
    click_button "Вход"
  end
end