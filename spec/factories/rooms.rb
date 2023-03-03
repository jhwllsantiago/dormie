FactoryBot.define do
  factory :room do
    name { "room name" }
    description { "description" }
    rent { 3000 }
    capacity { 5 }
    vacancies { 4 }
    tags { [] }
  end
end