# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

owner = Owner.create(
  name: "John Doe",
  contact: "1234567890",
  status: 0,
  email: "johndoe@example.com",
  password: "password",
  password_confirmation: "password"
)

occupant = Occupant.create(
  name: "Jane Doe",
  email: "janedoe@example.com",
  password: "password",
  password_confirmation: "password"
)

location = Location.create(
  name: "location name",
  address: "address",
  barangay: "barangay",
  city: "city",
  province: "province"
)

room = Room.create(
  name: "room name",
  description: "room description",
  rent: 10000.0,
  capacity: 10,
  vacancies: 5,
  tags: ["room tag 1", "room tag 2"],
  owner: owner,
  location: location
)

Schedule.create(
  mon: [true, true, false, false],
  tue: [false, true, false, true],
  wed: [true, true, false, false],
  thu: [false, true, false, true],
  fri: [true, true, false, false],
  sat: [false, true, false, true],
  sun: [true, true, false, false],
  owner: owner
)

Review.create(
  rating: 4,
  title: "review title",
  comment: "review comment",
  room: room,
  occupant: occupant
)