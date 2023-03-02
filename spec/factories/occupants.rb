FactoryBot.define do
  factory :occupant do
    name { "Jane Doe" }
    email { "janedoe@example.com" }
    password { "password" }
    password_confirmation { "password" }
    confirmed_at { Time.now }
  end
end