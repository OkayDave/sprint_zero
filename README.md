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

## 🧰 Included Gems & Tools

| Purpose               | Gem/Tool     |
|-----------------------|--------------|
| Admin Panel           | `avo`        | 
| Authentication        | `devise`     |
| Authorisation         | `pundit`     |
| Database              | `sqlite3`    |
| Frontend              | `bulma-rails`, `stimulus-rails`, `turbo-rails` |
| Linting               | `rubocop`    |
| Local Development     | `awesome_print`, `bullet`, `dotenv`, `letter_opener`, `overcommit` |
| Rails                 | `rails 8.0.2`|
| Ruby                  | `ruby 3.4.2` |
| Security Scanning     | `brakeman`   |
| Testing               | `capybara`, `factory_bot_rails`, `faker`, `pundit-matchers`, `rspec-rails`, `rswag`, `simplecov` |
| View Templates        | `haml-rails` |

## 📦 Included Concerns

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

#### Example URLs

```ruby
# With name
article = Article.create(name: "Hello World!")
article.to_param # => "123-hello-world"

# With title
article = Article.create(title: "Welcome to Rails")
article.to_param # => "123-welcome-to-rails"

# With special characters
article = Article.create(name: "What's New in 2024?")
article.to_param # => "123-whats-new-in-2024"
```

## 🚀 Getting Started

```bash
git clone git@github.com:OkayDave/sprint_zero.git your_new_app_name
cd your_new_app_name
bin/setup
bin/dev
```

### Setting Up Your Repository

After cloning and setting up the project, you'll want to set up your own repository:

```bash
# Remove the original remote
git remote remove origin

# Add your new repository as the origin
git remote add origin git@github.com:OkayDave/sprint_zero.git

# Push your code to the new repository
git push -u origin main
```

### Environment Configuration

This project uses [dotenv](https://github.com/bkeepers/dotenv) for environment configuration. After cloning the repository, copy the example environment file:

```bash
cp .env.example .env
```

You can then customise your local environment variables in `.env`. For more information about environment variable overrides, see the [dotenv documentation](https://github.com/bkeepers/dotenv#what-other-env-files-can-i-use).

## 💡 Contributing

Feel free to fork, clone, and make PRs. If there's a configuration or gem you think should be included, open an issue and let's discuss.

# Git Hooks

This project uses [overcommit](https://github.com/sds/overcommit) to manage Git hooks. When you first clone the repository, run:

```bash
bin/setup
```

This will set up your development environment, including:
- Installing dependencies
- Setting up the database
- Installing and configuring git hooks

The following pre-commit hooks are configured:
- RuboCop: Automatically fixes style issues and fails if there are unfixable issues
- RSpec: Runs the test suite and fails if any tests fail

If you need to bypass the hooks for a specific commit (not recommended), you can use:

```bash
OVERCOMMIT_DISABLE=1 git commit
```
