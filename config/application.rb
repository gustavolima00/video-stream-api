require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module VideoStreamApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets tasks))

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :post, :put, :delete, :options]
      end
    end

    config.hosts = [
      IPAddr.new("0.0.0.0/0"),        # All IPv4 addresses.
      IPAddr.new("::/0"),             # All IPv6 addresses.
      "localhost",                    # The localhost reserved domain.
      ENV["RAILS_DEVELOPMENT_HOSTS"]  # Additional comma-separated hosts for development.
    ]

    config.enable_dependency_loading = true
    config.autoload_paths << Rails.root.join('app/serializers')
    config.autoload_paths << Rails.root.join('app/services')
  end
end
