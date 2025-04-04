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
- **Anthropic's Calude Sonnet** for AI/LLM integration

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

article = Article.create(name: "My First Article")
article.to_param # => "123-my-first-article"
```

The concern will look for attributes in this order:
1. `name` (if present)
2. `title` (if present)
3. `slug` (if present)

If none of these attributes are present, it will return a blank string.

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

Replace references to SprintZero with your own app name. I use Find and Replace in my editor but if you're brave and smarter than me you could use something like `sed`. Here's what you're looking for though. There's are 30-40 refs in total.

```
sprintzero
SprintZero
sprint_zero

```

Make any changes you need to your Database setup. I default to `sqlite3` with values declared in the `.env*.local` files, so if you want an alternative store then add them to your Gemfile.

Last thing is to run the `bin/setup` script. This will install your bundle; install your js dependencies; configure pre-commit Git hooks via `overcommit`; and create your DB with the schema and seeds.

```bash
bin/setup
```
Now you're ready to roll. The procfile is configured to run `rails s`, watch for CSS changes, and run the worker processes.

```bash
bin/dev
```

Have fun, you productive, maginificient person!

### Environment Vars

SprintZero uses [dotenv](https://github.com/bkeepers/dotenv) for environment configuration.

# Git Hooks

This project uses [overcommit](https://github.com/sds/overcommit) to manage Git hooks. When you first clone the repository, run:

The following pre-commit hooks are configured:
- RuboCop: Automatically fixes style issues and fails if there are unfixable issues
- RSpec: Runs the test suite and fails if any tests fail

### Cursor Rules

I've added a couple of rules for Cursor's AI Agent. You can find them in the `.cursor/rules` folder.

These set out my guidelines for how Cursor returns autocompletions, suggestions, and generated content.

I currently have rules for Ruby implementation code and Rspec tests. They're not perfect but they work quite well.

## 💡 Contributing

Feel free to fork, clone, and make PRs. If there's a configuration or gem you think should be included, open an issue and let's discuss.

