source 'https://rubygems.org'
ruby '2.0.0'


gem 'rails', '4.0.2' #Сам Rails
gem 'bootstrap-sass', '~> 3.0.3.0' #Bootstrap Twitter

group :development, :test do
  gem 'sqlite3', '~> 1.3.8' #БД
  gem 'rspec-rails', '~> 2.14.0' #RSpec  тестирование
end

group :test do
  gem 'selenium-webdriver', '~> 2.39.0' #драйвер Selenium(автоматизация тестирования веб-приложения в реальном браузере) для Capybara
  gem 'capybara', '~> 2.2.0' #Тестирование через имитацию взаимодействия
end

gem 'sass-rails', '~> 4.0.1' #Язык стилей Sass
gem 'uglifier', '>= 2.4.0' #Сжатие файлопровода
gem 'coffee-rails', '~> 4.0.1' #CoffeeScript
gem 'jquery-rails', '~> 3.0.4' #JavaScript библиотека
gem 'turbolinks', '~> 2.1.0' #Ускоряет загрузку/обновление страниц
gem 'jbuilder', '~> 2.0.1' #Шаблоны JSON

group :doc do
  gem 'sdoc', '~> 0.3.20', require: false #Для синтаксиса файлов документации
end

group :production do
  gem 'pg', '~> 0.17.1' #БД
  gem 'rails_12factor', '~> 0.0.2' #Для размещения на Heroku
end