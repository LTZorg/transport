require 'spec_helper'

describe "Static pages" do

	subject {page}

	  let(:base_title) { "Заявки на перевозки" }

	  describe "Home page" do
	  	before {visit root_path}

	    it { should have_content('Добро пожаловать') }
		it { should have_title(full_title('')) }
		it { should_not have_title('Заявки на перевозки |') }

	  end


	  describe "Help page" do
	  	before {visit help_path}

	    it { should have_content('Справка') }
	    it { should have_title(full_title('Справка')) }

	  end

	  describe "Contact page" do
	  	before {visit contact_path}

	    it { should have_content('Контакты') }
	    it { should have_title(full_title('Контакты')) }

	  end

	  it "должна содержать правильные ссылки" do
	  	visit root_path
	  	click_link "Заявки на перевозки"
	  	should have_content('Добро пожаловать')
	  	click_link "Заявки"
	  	should have_content('Добро пожаловать')
	  	click_link "Справка"
	  	should have_content('Справка')
	  	click_link "Контакты"
	  	should have_content('Контакты')
	  end	

end