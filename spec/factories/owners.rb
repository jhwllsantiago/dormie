FactoryBot.define do
  factory :owner do
    name { "John Doe" }
    contact { "09123123123" }
    email { "johndoe@example.com" }
    password { "password" }
    password_confirmation { "password" }
    confirmed_at { Time.now }
  end
end