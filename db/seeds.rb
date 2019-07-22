User.create!(name: "Tung",
  email: "tung@gmail.com",
  password:"a147258369",
  password_confirmation: "a147258369",
  admin: true,
  activated: true,
  activated_at: Time.zone.now)

99.times do |n|
name  = Faker::Name.name
email = "tung-#{n+1}@gmail.com"
password = "password"
User.create!(name:  name,
   email: email,
   password: password,
   password_confirmation: password,
   activated: true,
   activated_at: Time.zone.now)
end
