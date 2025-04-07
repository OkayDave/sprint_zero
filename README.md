[![CI](https://github.com/OkayDave/sprint_zero/actions/workflows/ci.yml/badge.svg)](https://github.com/OkayDave/sprint_zero/actions/workflows/ci.yml)

# SprintZero

**Kickstart your next Rails project with sensible defaults and a curated setup.**

SprintZero is a boilerplate Ruby on Rails application designed to save time and effort when starting a new project. It comes pre-configured with modern defaults and carefully selected tools so you can get straight to building your app — not configuring it.

Setting up a new Rails application can often feel repetitive — setting up the same gems, tweaking the same config files, installing the same frameworks. SprintZero removes that friction. Clone it, rename it, and you're off.

## ✨ Features

- **Ruby 3.4.2** & **Rails 8.0.2**
- **SQLite3** for development database
- **Turbo** and **Hotwire** enabled out of the box
- **Bulma** CSS framework for sleek and responsive UIs
- **HAML** templating for cleaner view code
- **Brakeman** and **Rubocop** for security and linting
- **Rspec** for robust testing
- **Avo** as the admin panel
- **Anthropic's Claude Sonnet** for AI/LLM integration

## 🧰 Included Gems & Tools

| Purpose               | Gem/Tool     |
|-----------------------|--------------|
| Admin Panel           | `avo`        | 
| AI                    | `omniai_anthropic` |
| Authentication        | `devise`     |
| Authorisation         | `pundit`     |
| Database              | `sqlite3`    |
| Frontend              | `bulma-rails`, `stimulus-rails`, `turbo-rails` |
| Linting               | `rubocop`    |
| Local Development     | `awesome_print`, `bullet`, `dotenv`, `letter_opener`, `overcommit` |
| Pagination            | `pagy`       |
| Rails                 | `rails 8.0.2`|
| Ruby                  | `ruby 3.4.2` |
| Security Scanning     | `brakeman`   |
| Testing               | `capybara`, `factory_bot_rails`, `faker`, `pundit-matchers`, `rspec-rails`, `rswag`, `simplecov` |
| View Templates        | `haml-rails` |

## 📦 Helpful Concerns

### Slugged

The `Slugged` concern provides URL-friendly parameterisation for your models. When included, it:

1. Overrides the `to_param` method to create SEO-friendly URLs
2. Provides a `name_or_title` method that intelligently selects the best identifier for your model

#### Usage

```ruby
class Article < ApplicationRecord
  include Slugged
end

# to_param override
article = Article.create(name: "My First Article")
article.to_param # => "123-my-first-article"

# url helper
article_path(123) # => "/articles/123-my-first-article"
```

The `#name_or_title` method will look for attributes in this order:
1. `name` (if present)
2. `title` (if present)
3. `slug` (if present)

If none of these attributes are present, `#name_or_title` will return a blank string, and `#to_param` will fallback to default Rails behaviour; so `article_path(123) # => /articles/1`

### HasAIContent

The `HasAIContent` concern assists with automatically generating content with Anthropic's Claude Sonnet. 

See the `StaticPage` model for an example of its implementation.

First, you must create an `AI::Prompt` (easy via the avo panel `/admin`).

You should then add the relevant columns to the Model you wish to generate content for.

```ruby
class AddAIContentColsToArticle < ActiveRecord::Migration[8.0]
  def change
    add_column :articles, :content, :text # omit if you're using ActionText for content
    add_column :articles, :prompt_id, :integer
    add_column :articles, :prompt_additions, :text
    add_column :articles, :generate_content_on_create, :boolean, default: false

    # add_index :articles, :prompt_id # optional, add this if you're planning on querying based on prompt_id
  end
end
```

Include the Concern

```ruby
class Article < ApplicationRecord
  include HasAIContent
end
```

Set the `prompt_id`, `prompt_additions`, and `generate_content_on_create` before saving the new record.


```ruby
@article = Article.new(article_params)
@article.generate_content_on_create = true
@article.prompt_additions = "This article is about how much fun the Ruby programming language is. Please write an article about this with 5 mind-blowing facts about Ruby."
@article.prompt_id = AI::Prompt.first.id
@article.save
```

Provided `@article` is valid, a background job will be created via `AI::GenerateContentFromPromptJob` which calls the `AI::ContentGenerator` service. This service will build a prompt based off the provided `AI::Prompt` and `@record.prompt_additions` and return the results to `@record.content` once complete.

## 🚀 Getting Started - Making SprintZero your own

SprintZero is intended as a one-off starter kit rather than an engine/template/generator or whatever. It's not something you would update your own repo against in the future. 

Clone -> Personalise -> Crack On.

So, first thing you need to do is treat yourself to a new repo on Github or Gitlab or whatever you're feeling.

Then, grab a clone of this repo.

```bash
git clone git@github.com:OkayDave/sprint_zero.git your_new_app_name
cd your_new_app_name
```

After cloning, you'll want to adjust the origin to your new repo

```bash
# Remove the SprintZero remote
git remote remove origin

# Add your new repository as the origin
git remote add origin git@github.com:your_username/your_new_app_name.git

# Give it a cheeky push, if you like
git push -u origin main
```
Get you `.env` files in order. I'd recommend having separate files for each env:

```bash
  cp .env.example .env.development.local
  cp .env.example .env.test.local
```

Replace the values within these two new files with your own.

Replace references to SprintZero with your own app name. I use Find and Replace in my editor but if you're brave and smarter than me you could use something like `sed`. Here's what you're looking for though. There's around 40ish references in total.

```
sprintzero
SprintZero
sprint_zero

```

Generate a new `config/master.key` by throwing away the current secrets and creating a new one.

```bash
rm config/credentials.yml.enc
bin/rails credentials:edit 
```

Make any changes you need to your Database setup. I default to `sqlite3` with values declared in the `.env*.local` files, so if you want to use an alternative datastore then you'll also need to add the supporting gem to the Gemfile.

Last thing is to run the `bin/setup` script. This will install your bundle; install your js dependencies; configure pre-commit Git hooks via `overcommit`; and create your DB with the schema and seeds.

```bash
bin/setup
```
Now you're ready to roll. The procfile is configured to run `rails s`, watch for CSS changes, and run the worker processes.

```bash
bin/dev
```

**Have fun, you productive, magnificent person!**

## Environment Vars

SprintZero uses [dotenv](https://github.com/bkeepers/dotenv) for environment configuration.

See `.env.example` and copy the file to your `*.local` overrides as described in the instructions above.

```bash
# Database
DB_HOST=localhost
DB_USER=local
DB_PASSWORD=password
DB_NAME=storage/sprintzero.sqlite3
DB_QUEUE_NAME=storage/sprintzero_queue.sqlite3
DB_CABLE_NAME=storage/sprintzero_cable.sqlite3
DB_ADAPTER=sqlite3

# Anthropic
ANTHROPIC_API_KEY=your_anthropic_api_key

# Job Concurrency
JOB_CONCURRENCY=1

# Stripe
STRIPE_ENABLED=false
STRIPE_PUBLIC_KEY=your_stripe_public_key
STRIPE_PRIVATE_KEY=your_stripe_private_key
STRIPE_SIGNING_SECRET=your_stripe_signing_secret
STRIPE_WEBHOOK_RECEIVE_TEST_EVENTS=true
STRIPE_CUSTOMER_PORTAL_URL=your_stripe_customer_portal_url
```
## Subscriptions

Stripe is integrated to support paid subscriptions. It's as low-code integrated as possible, redirecting users to Stripe-hosted pages. Administration is also done directly through the [Stripe Dashboard]('https://dashboard.stripe.com/test/dashboard')

You'll need to configure your Stripe account with Subscription Products, API keys, signing secret, and the customer billing portal. Store this data in your `.env.development.local` file.

Note: Stripe hides the link to 'Developers' at the bottom of the Dashboard's sidebar.

| Required Info | Where to find It |
|--|--|
| Public / Private API Keys | [Developers  -> API Keys](https://dashboard.stripe.com/test/apikeys) |
| Webhooks (Production only) | [Developers -> Webhooks](https://dashboard.stripe.com/test/webhooks) |
| Signing Secret | Stripe CLI (`stripe login`) | 

Once you have these values set, run the Stripe webhooks listener. It's configured in the `Procfile` so is part of `dev/bin`, or you can run it manually via `bin/wh` |

| Required Action | Where to do it |
| -- | -- |
| Create Product Plans | [Billing -> Get started with Billing -> Set up your product catalogue](https://dashboard.stripe.com/test/billing/starter-guide) |
| Activate Customer Portal Link | [Billing -> Get started with Billing -> Set up a self-serve customer portal](https://dashboard.stripe.com/test/settings/billing/portal) |

## Git Hooks

SprintZero uses [overcommit](https://github.com/sds/overcommit) to manage Git hooks. When you first clone the repository, run:

The following pre-commit hooks are configured:
- RuboCop: Automatically fixes style issues and fails if there are unfixable issues
- RSpec: Runs the test suite and fails if any tests fail

## Cursor Rules

I've added a couple of rules for Cursor's AI Agent. You can find them in the `.cursor/rules` folder.

These set out my guidelines for how Cursor returns autocompletions, suggestions, and generated content.

I currently have rules for Ruby implementation code and Rspec tests. They're not perfect but they work quite well.

## Alternative Rails Starter Apps / Generators / Templates

SprintZero isn't the only offering in the community. There's a few others, with different bundled software, pricing, licensing, defaults, configurability, etc.

For example:
- [Bullet Train](https://bullettrain.co/)
- [RailsNotes StarterKit](https://railsnotes.xyz/starter-kit)
- [Suspenders](https://github.com/thoughtbot/suspenders)
- [Rails7Igniter](https://rails7igniter.vercel.app/)
- [instant_rails](https://github.com/jasonswett/instant_rails)
- [Jumpstart Pro](https://jumpstartrails.com/)
- [Nextgen](https://github.com/mattbrictson/nextgen)


## 💡 Contributing

Feel free to fork, clone, and make PRs. If there's a configuration or gem you think should be included, open an issue and let's discuss. Or just fork it and start your own starter kit. Call it SprintOne or something. You do you. I'm (probably) not your boss.

