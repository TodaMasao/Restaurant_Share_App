source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.2'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # rspec(テストライブラリ)を導入する
  gem 'rspec-rails'
  # factorybot(テストデータ作成支援絵ライブラリ)を導入する
  gem 'factory_bot_rails'
  # webmock(テスト時に仮想サーバとしてレスポンスを返すライブラリ)を導入する
  gem 'webmock'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '~> 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # better_errors/binding_of_caller(デバッグ用)を導入する
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# slim(View出力のテンプレートエンジン)を導入する
gem 'html2slim'
gem 'slim-rails'

# bootstrap(cssテンプレート)を導入する
gem 'bootstrap'

# devise(ユーザ認証機能のライブラリ)を導入する
gem 'devise'

# pry-hoge(デバッグ用ライブラリ)を導入する
gem 'pry-byebug'
gem 'pry-doc'
gem 'pry-rails'

# kaminari(ページネーションライブラリ)を導入する
gem 'kaminari'

# font-awesome-sass(アイコンセットライブラリ)を導入する
gem 'font-awesome-sass'

# carrier(画像アップロードライブラリ)を導入する
gem 'carrierwave'

# carrier(画像アップロードライブラリ(aws))を導入する
gem 'carrierwave-aws'

# gon(jsでrails変数を扱うためのライブラリ)を導入する
gem 'gon'

# rubocop(構文の静的解析ツール)を導入する
gem 'rubocop', require: false
gem 'rubocop-performance', require: false
gem 'rubocop-rails', require: false
gem 'rubocop-rspec'
