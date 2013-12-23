require 'spec_helper'

describe "Static pages" do

	  let(:base_title) { "Заявки на перевозки" }

	  describe "Home page" do

	    it "должна содержать контент 'Добро пожаловать'" do
	      visit '/static_pages/home'
	      expect(page).to have_content("Добро пожаловать")
	    end

		it "должна содержать заголовок 'Заявки на перевозки'" do
	      visit '/static_pages/home'
	      expect(page).to have_title("#{base_title}")
	    end

		it "не должна содержать заголовок 'Заявки на перевозки |'" do
	      visit '/static_pages/home'
	      expect(page).not_to have_title("Заявки на перевозки |")
	    end

	  end


	  describe "Help page" do

	    it "должна содержать контент 'Справка'" do
	      visit '/static_pages/help'
	      expect(page).to have_content('Справка')
	    end
	    
	    it "должна содержать заголовок 'Заявки на перевозки | Справка'" do
	      visit '/static_pages/help'
	      expect(page).to have_title("#{base_title} | Справка")
	    end

	  end

	  describe "Contact page" do

	    it "должна содержать контент 'Контакты'" do
	      visit '/static_pages/contact'
	      expect(page).to have_content('Контакты')
	    end
	    
	    it "должна содержать заголовок 'Заявки на перевозки | Контакты'" do
	      visit '/static_pages/contact'
	      expect(page).to have_title("#{base_title} | Контакты")
	    end

	  end

end