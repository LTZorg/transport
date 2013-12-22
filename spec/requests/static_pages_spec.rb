require 'spec_helper'

describe "Static pages" do

	  let(:base_title) { "Заявки на перевозку" }

	  describe "Home page" do

	    it "должна содержать контент 'Заявки на перевозку'" do
	      visit '/static_pages/home'
	      expect(page).to have_content("Заявки на перевозку")
	    end

		it "должна содержать заголовок 'Заявки на перевозку'" do
	      visit '/static_pages/home'
	      expect(page).to have_title("#{base_title}")
	    end

		it "не должна содержать заголовок 'Заявки на перевозку |'" do
	      visit '/static_pages/home'
	      expect(page).not_to have_title("Заявки на перевозку |")
	    end

	  end


	  describe "Help page" do

	    it "должна содержать контент 'Справка'" do
	      visit '/static_pages/help'
	      expect(page).to have_content('Справка')
	    end
	    
	    it "должна содержать заголовок 'Заявки на перевозку | Справка'" do
	      visit '/static_pages/help'
	      expect(page).to have_title("#{base_title} | Справка")
	    end

	  end

	  describe "Contact page" do

	    it "должна содержать контент 'Контакты'" do
	      visit '/static_pages/contact'
	      expect(page).to have_content('Контакты')
	    end
	    
	    it "должна содержать заголовок 'Заявки на перевозку | Контакты'" do
	      visit '/static_pages/contact'
	      expect(page).to have_title("#{base_title} | Контакты")
	    end

	  end

end