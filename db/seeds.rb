require "faker"
require "open-uri"

# puts "🧼 Cleaning up posts..."
# Post.delete_all

# puts "📸 Fetching Unsplash image URLs..."

# search_terms = %w[
#   doctor nurse hospital surgery healthcare stethoscope xray
#   medicine vaccine lab dentist paramedic mri scan gloves mask
#   patient ultrasound pharmacy microscope cardiology
# ]

# image_urls = []

# search_terms.each do |term|
#   begin
#     photos = Unsplash::Photo.search(term, 1, 10)
#     urls = photos.map { |photo| photo.urls.regular }.compact
#     image_urls.concat(urls)
#     puts "✅ Fetched #{urls.size} images for '#{term}'"
#   rescue => e
#     puts "⚠️  Failed to fetch for '#{term}': #{e.message}"
#   end
# end

# puts "🎲 Shuffling #{image_urls.size} collected images..."
# image_urls.shuffle!

# puts "📝 Creating 200 posts..."

# 200.times do |i|
#   Post.create!(
#     title: Faker::Book.title,
#     body: Faker::Lorem.paragraphs(number: 4).join("\n\n"),
#     source: ["Diximity News", "Medical Journal", "Healthline", "Science Daily"].sample,
#     published_at: Faker::Date.between(from: 2.years.ago, to: Date.today),
#     image_url: image_urls[i % image_urls.size] # reuse images if < 200
#   )
# end

# puts "✅ Seed complete with 200 posts using #{image_urls.size} unique images!"

# db/seeds.rb


specialties = [
  "Cardiology", "Pediatrics", "Neurology", "Dermatology", "Emergency Medicine",
  "Gynecology", "Orthopedics", "Oncology", "Radiology", "General Surgery"
]

20.times do
  gender = ["men", "women"].sample
  image_number = rand(1..99)
  profile_image_url = "https://randomuser.me/api/portraits/#{gender}/#{image_number}.jpg"

  user = User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.unique.email,
    password: "password123",
    password_confirmation: "password123",
    bio: Faker::Lorem.paragraph(sentence_count: 5),
    specialty: specialties.sample,
    profile_summary: Faker::Quote.matz,
    address_attributes: {
      address1: Faker::Address.street_address,
      address2: Faker::Address.secondary_address,
      city: Faker::Address.city,
      state: Faker::Address.state_abbr,
      zip: Faker::Address.zip_code,
      country: "USA",
      tax_phone_number: Faker::PhoneNumber.phone_number,
      latitude: Faker::Address.latitude,
      longitude: Faker::Address.longitude
    }
  )

  user.profile_picture.attach(
    io: URI.open(profile_image_url),
    filename: "profile.jpg",
    content_type: "image/jpeg"
  )

  puts "✅ Created: #{user.name} (#{user.specialty})"
end