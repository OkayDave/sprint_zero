# SprintZero

**Kickstart your next Rails project with sensible defaults and a curated setup.**

SprintZero is a boilerplate Ruby on Rails application designed to save time and effort when starting a new project. It comes pre-configured with modern defaults and carefully selected tools so you can get straight to building your app — not configuring it.

## ✨ Features

- **Ruby 3.4.2** & **Rails 8.0.2**
- **SQLite3** for development database
- **Turbo** and **Hotwire** enabled out of the box
- **Bulma** CSS framework for sleek and responsive UIs
- **HAML** templating for cleaner view code
- **Brakeman** and **Rubocop** for security and linting
- **Rspec and friends** for robust testing

## 🔧 Why SprintZero?

Setting up a new Rails application can often feel repetitive — setting up the same gems, tweaking the same config files, installing the same frameworks. SprintZero removes that friction. Clone it, rename it, and you're off.


## 🧰 Included Gems & Tools

| Purpose             | Gem/Tool     |
|---------------------|--------------|
| Application Framework | `rails`     |
| Language Runtime     | `ruby 3.4.2` |
| Database             | `sqlite3`    |
| Frontend             | `turbo-rails`, `stimulus-rails`, `bulma-rails` |
| View Templates       | `haml-rails` |
| Linting              | `rubocop`    |
| Security Scanning    | `brakeman`   |
| Testing             | `rspec-rails`, `factory_bot_rails`, `rswag`, `simplecov`, `faker`, `pundit-matchers`, `capybara` |
| Authentication      | `devise`     |
| Authorisation       | `pundit`     |
| Local Development   | `letter_opener`, `overcommit` |

## 🚀 Getting Started

```bash
git clone https://github.com/OkayDave/sprint_zero.git your_new_app_name
cd your_new_app_name
bin/setup
bin/dev

```

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
