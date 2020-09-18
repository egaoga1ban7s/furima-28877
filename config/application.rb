require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Furima28877
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    
    config.generators do |g|
      g.stylesheets false
      g.javascripts false
      g.helper false
      g.test_framework false
    end
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| html_tag }

    config.i18n.default_locale = :ja
    # config.active_model.i18n_customize_full_message = true
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
