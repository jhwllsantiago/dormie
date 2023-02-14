# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

owner = Owner.new(
  name: "John Doe",
  contact: "1234567890",
  status: 0,
  email: "johndoe@example.com",
  password: "password",
  password_confirmation: "password"
)
owner.skip_confirmation!
owner.save

occupant = Occupant.new(
  name: "Jane Doe",
  email: "janedoe@example.com",
  password: "password",
  password_confirmation: "password"
)
occupant.skip_confirmation!
occupant.save

location = Location.create(
  name: "El Pueblo Manila",
  address: "B1214 Anonas St., Barangay 630, City of Manila",
  unit: "B1214",
  street: "Anonas St.",
  barangay: "Barangay 630",
  city: "City of Manila",
  query: "El+Pueblo+Manila,Anonas+St.,Barangay+630,City+of+Manila",
  owner: owner
)

room = Room.create(
  name: "The Expanse",
  description: "Suspendisse et vehicula urna. Nam sit amet orci hendrerit, fermentum dolor in, luctus mi. Cras porta dapibus libero, nec interdum tellus ornare nec. Nulla sollicitudin urna enim, id dapibus quam viverra in. Maecenas id eleifend enim, quis mollis magna. Aliquam erat volutpat. Mauris sit amet accumsan turpis. Aliquam risus massa, pellentesque sit amet lectus et, feugiat porttitor tellus. Nulla eu mattis lacus.",
  rent: 10000.0,
  capacity: 10,
  vacancies: 5,
  tags: ["1", "2", "3", "7"],
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
  title: "So clean, So good.",
  comment: "Vivamus diam justo, finibus at quam at, facilisis aliquet turpis. Vivamus mattis ut arcu convallis accumsan. Nullam volutpat nisl orci, non egestas ante condimentum vehicula. Pellentesque tristique consectetur turpis sit amet pellentesque.",
  room: room,
  occupant: occupant
)

Tag.create([
  {name: "Reception"},
  {name: "Parking"},
  {name: "Food Hall"},
  {name: "Elevator"},
  {name: "Laundromat"},
  {name: "Wifi"},
  {name: "Roof Deck"}
])