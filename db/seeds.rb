require 'faker'
Event.destroy_all
Venue.destroy_all
User.destroy_all

# Users
admin = User.new(
  email: 'admin@example.co',
  password: '111111',
  password_confirmation: '111111',
  first_name: 'Admin',
  last_name: 'admin',
  jti: SecureRandom.uuid
)
admin.skip_confirmation!
admin.save!
admin.add_role(:admin)

5.times do |i|
  organizer = User.new(
    email: "organizer#{i + 1}@example.co",
    password: '111111',
    password_confirmation: '111111',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    jti: SecureRandom.uuid
  )
  organizer.skip_confirmation!
  organizer.save!
  organizer.add_role(:organizer)
end

20.times do |i|
  user = User.new(
    email: "assistant#{i + 1}@example.co",
    password: '111111',
    password_confirmation: '111111',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    jti: SecureRandom.uuid
  )
  user.skip_confirmation!
  user.save!
end

# Venues
[
  { name: 'Matik Matik', address: 'Cra. 15 #52-17, Bogotá', capacity: 100 },
  { name: 'Casa Kilele', address: 'Cl. 64 #3a-53, Bogotá', capacity: 80 },
  { name: 'Espacio KB', address: 'Cra 5 #26C-47, Bogotá', capacity: 120 },
  { name: 'Mutuo Casa Taller', address: 'Calle 36 # 15 - 23, Bogotá', capacity: 50 },
  { name: 'La Barca', address: 'Dg42a # 20-45', capacity: 70 },
  { name: 'Casa Rat Trap', address: 'Cra. 4a #54-18, Bogotá', capacity: 60 },
  { name: 'Espacio Odeón', address: 'Cra. 5 #12c-73, Bogotá', capacity: 150 },
  { name: 'La Ventana Galería', address: 'Cra. 25 #40-34, Bogotá', capacity: 40 }
].map do |venue_data|
  Venue.create!(venue_data.merge(created_by: User.with_role(:organizer).sample))
end

# Events
categories = [
  'Música Independiente', 'Arte Experimental', 'Teatro Alternativo',
  'Cine Indie', 'Talleres Creativos', 'Danza Contemporánea', 'Performance', 'Exposiciones'
]

40.times do
  start_time = Faker::Time.between(from: DateTime.now, to: 3.months.from_now)
  category = categories.sample
  event_name = case category
               when 'Música Independiente'
                 "#{Faker::Music.genre} en vivo: #{Faker::Name.name}"
               when 'Arte Experimental'
                 "Exposición: #{Faker::Lorem.words(number: 3).join(' ').capitalize}"
               when 'Teatro Alternativo'
                 "#{Faker::Book.title} - Teatro Experimental"
               when 'Cine Indie'
                 "Proyección: #{Faker::Movie.title}"
               when 'Talleres Creativos'
                 "Taller de #{Faker::Job.field} Alternativo"
               when 'Danza Contemporánea'
                 "#{Faker::Ancient.god} - Danza Experimental"
               when 'Performance'
                 "Performance: #{Faker::Hipster.words(number: 3).join(' ').capitalize}"
               when 'Exposiciones'
                 "#{Faker::Artist.name} presenta: #{Faker::Lorem.words(number: 2).join(' ').capitalize}"
               end

  event = Event.new(
    name: event_name,
    description: Faker::Lorem.paragraph(sentence_count: 5),
    date: start_time.to_date,
    # start_time: start_time,
    # end_time: start_time + rand(1..4).hours,
    price_cents: [0, 5000, 10000, 15000, 20000].sample,
    price_currency: 'COP',
    organizer: User.with_role(:organizer).sample,
    venue: Venue.all.sample,
    max_attendees: rand(20..100),
    status: Event.statuses.keys.sample
  )

  image_url = "https://source.unsplash.com/800x600/?#{category.parameterize}"
  # event.image.attach(io: URI.open(image_url), filename: "#{event.name.parameterize}.jpg")
  img_file = File.open(File.join(Rails.root,'app/assets/images/event.jpg'))
  event.image.attach(io: img_file, filename: "#{event.name.parameterize}.jpg")
  event.save!
end

