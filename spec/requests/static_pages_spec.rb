require 'spec_helper'

describe "Static pages" do

	  describe "Home page" do

	    it "должна содержать контент 'Заявки на перевозку'" do
	      visit '/static_pages/home'
	      expect(page).to have_content('Заявки на перевозку')
	    end

		it "должна содержать заголовок 'Заявки на перевозку'" do
	      visit '/static_pages/home'
	      expect(page).to have_title('Заявки на перевозку')
	    end

	  end


	  describe "Help page" do

	    it "должна содержать контент 'Справка'" do
	      visit '/static_pages/help'
	      expect(page).to have_content('Справка')
	    end
	    
	    it "должна содержать заголовок 'Заявки на перевозку | Справка'" do
	      visit '/static_pages/help'
	      expect(page).to have_title('Заявки на перевозку | Справка')
	    end

	  end

end