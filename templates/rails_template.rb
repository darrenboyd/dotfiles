initializer 'frozen_string_in_generators.rb', <<-CODE
  return unless defined?(::Rails::Generators)

  module RailsGeneratorFrozenStringLiteralPrepend
    RUBY_EXTENSIONS = %w[.rb .rake].freeze

    def render
      return super unless RUBY_EXTENSIONS.include? File.extname(destination)
      "# frozen_string_literal: true\\n\\n\#{super}"
    end
  end

  Thor::Actions::CreateFile.prepend RailsGeneratorFrozenStringLiteralPrepend
CODE

gem 'amazing_print', group: :development
gem 'rails_semantic_logger'

gem 'phlex-rails'

gem_group :development, :test do
  gem 'factory_bot_rails'
end

gem_group :development do
  gem 'hotwire-livereload'
end

run 'bundle install'
