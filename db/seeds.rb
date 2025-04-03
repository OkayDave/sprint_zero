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
admin = User.find_or_create_by!(email: 'admin@example.com') do |user|
  user.password = 'password123'
  user.password_confirmation = 'password123'
  user.role = 'admin'
  user.confirmed_at = Time.current

  puts "Created admin user: #{admin.email}"
end


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

puts "Created static pages"

# Create AI prompts
[
  {
    title: 'Three Random Facts',
    content: 'Please generate a short article with three random facts. The generated content can use the following html tags: <p>, <h1>, <h2>, <strong>, <em>, <ul>, <li>, <a>, <blockquote>. Do not use any other tags or styling.',
    response_format: "Please respond with a JSON object which, as a minimum contains a `content` key which contains the generated HTML content. The response within `content` should be parseable via Ruby's `JSON.parse` method without any modifications.",
    additional_options: {
      model: OmniAI::Anthropic::Chat::Model::CLAUDE_3_7_SONNET_LATEST,
      temperature: 0.5
    }
  }
].each do |prompt_attrs|
  AI::Prompt.find_or_create_by!(title: prompt_attrs[:title]) do |prompt|
    prompt.content = prompt_attrs[:content]
    prompt.response_format = prompt_attrs[:response_format]
    prompt.additional_options = prompt_attrs[:additional_options]
  end
end

puts "Created AI prompts"
