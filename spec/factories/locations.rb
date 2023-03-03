FactoryBot.define do
  factory :location do
    name { ('a'..'z').to_a.shuffle.join }
    address_line { ('a'..'z').to_a.shuffle.join }
    city { ('a'..'z').to_a.shuffle.join }
    province { ('a'..'z').to_a.shuffle.join }
    full_address { ('a'..'z').to_a.shuffle.join }
    query { ('a'..'z').to_a.shuffle.join }
  end
end