# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
1000.times do
  generated_first_name = Faker::Name.first_name
  generated_last_name = Faker::Name.last_name

  contact = Contact.new(
                        first_name: generated_first_name,
                        last_name: generated_last_name,
                        email: Faker::Internet.free_email(name: "#{generated_first_name}.#{generated_last_name}"),
                        phone_number: Faker::PhoneNumber.phone_number
                        )
  contact.save
end