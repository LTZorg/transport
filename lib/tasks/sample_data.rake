namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "LTZorg",
                 email: "ltzorg@gmail.com",
                 password: "123456",
                 password_confirmation: "123456",
                 admin: true)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@gidr.ru"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end