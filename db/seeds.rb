# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create admin user
admin = User.create!(
  email: 'admin@example.com',
  password: 'password123',
  password_confirmation: 'password123',
  role: 'admin',
  confirmed_at: Time.current
)

puts "Created admin user: #{admin.email}"

# Create static pages
static_pages = [
  {
    title: 'About Us',
    content: 'Welcome to our application! We are dedicated to providing the best service to our users.',
    requires_sign_in: false
  },
  {
    title: 'Terms of Service',
    content: 'Please read these terms carefully before using our service.',
    requires_sign_in: false
  },
  {
    title: 'Privacy Policy',
    content: 'We take your privacy seriously. This policy explains how we handle your data.',
    requires_sign_in: false
  }
]

static_pages.each do |page_attrs|
  StaticPage.find_or_create_by!(title: page_attrs[:title]) do |page|
    page.content = page_attrs[:content]
    page.requires_sign_in = page_attrs[:requires_sign_in]
  end
end

puts "Created #{static_pages.size} static pages"
