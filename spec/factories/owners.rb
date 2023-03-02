FactoryBot.define do
  factory :owner do
    name { ('a'..'z').to_a.shuffle.join }
    contact { "09123123123" }
    email { "johndoe@example.com" }
    password { "password" }
    password_confirmation { "password" }
    confirmed_at { Time.now }
  end
end