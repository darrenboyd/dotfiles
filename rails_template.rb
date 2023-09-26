
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

gem "haml-rails"
gem "devise"

gem_group :development, :test do
  gem "rspec-rails"
  gem "factory_bot_rails"
end

gem_group :development do
  gem "hotwire-livereload"
end

run "bundle install"

generate("rspec:install")


run "gem install html2haml" # unneeded in bundle
[ "mailer", "application" ].each do |f|
  run "html2haml --erb app/views/layouts/#{f}.html.erb > app/views/layouts/#{f}.html.haml"
  run "rm -f app/views/layouts/#{f}.html.erb"
end



