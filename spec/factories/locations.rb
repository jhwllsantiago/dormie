FactoryBot.define do
  factory :location do
    name { ('a'..'z').to_a.shuffle.join }
    address_line { ('a'..'z').to_a.shuffle.join }
    city { ('a'..'z').to_a.shuffle.join }
    province { ('a'..'z').to_a.shuffle.join }
    full_address { ('a'..'z').to_a.shuffle.join }
    query { ('a'..'z').to_a.shuffle.join }
    latitude { 12.8797 }
    longitude { 121.7740 }
  end
end