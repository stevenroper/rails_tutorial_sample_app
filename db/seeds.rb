User.create!(name: 'Steven Roper',
             email: 'steven@example.com',
             password: 'stevenroper',
             password_confirmation: 'stevenroper',
             admin: true)

99.times do |n|
  name = Faker::Name.name
  email = "test-user-#{n+1}@example.com"
  password = 'password'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end