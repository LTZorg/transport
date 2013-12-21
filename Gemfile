source 'https://rubygems.org'
ruby '2.0.0'


gem 'rails' #Сам Rails

group :development, :test do
  gem 'sqlite3' #БД
  gem 'rspec-rails' #RSpec  тестирование
end

group :test do
  gem 'selenium-webdriver' #драйвер Selenium(автоматизация тестирования веб-приложения в реальном браузере) для Capybara
  gem 'capybara' #Тестирование через имитацию взаимодействия
end

gem 'sass-rails' #Язык стилей Sass
gem 'uglifier' #Сжатие файлопровода
gem 'coffee-rails', '4.0.1' #CoffeeScript
gem 'jquery-rails' #JavaScript библиотека
gem 'turbolinks' #Ускоряет загрузку/обновление страниц
gem 'jbuilder' #Шаблоны JSON

group :doc do
  gem 'sdoc', require: false #Для синтаксиса файлов документации
end

group :production do
  gem 'pg' #БД
  gem 'rails_12factor' #Для размещения на Heroku
end