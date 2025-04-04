FactoryBot.define do
  factory :ai_prompt, class: 'AI::Prompt' do
    title { 'Three Random Facts' }
    content { 'Please generate a short article with three random facts. The generated content can use the following html tags: <p>, <h1>, <h2>, <strong>, <em>, <ul>, <li>, <a>, <blockquote>. Do not use any other tags or styling.' }
    additional_options { {} }
    response_format { 'Please respond with a JSON object in the following format: {"content": "string"}. Please do not include any other text in your response.' }
  end
end
