require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MedodsApi
  class Application < Rails::Application

    SENSITIVE = Rails.application.config_for :sensitive_config
    # Setting up secret data
    ENV["DATABASE_NAME"] = SENSITIVE.database[:name]
    ENV["DATABASE_USERNAME"] = SENSITIVE.database[:username]
    ENV["DATABASE_PASSWORD"] = SENSITIVE.database[:password]

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address: SENSITIVE.smtp[:address],
      port: SENSITIVE.smtp[:port],
      user_name: SENSITIVE.smtp[:user_name],
      password: SENSITIVE.smtp[:password]
    }

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

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
  end
end
