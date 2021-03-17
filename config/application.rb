require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HotelManager
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
     config.i18n.load_path += Dir[Rails.root.join("config", "locales",
        "**", "*.{rb,yml}")]
    config.i18n.available_locales = [:en, :vi]
    config.i18n.default_locale = :en
    config.action_view.field_error_proc = Proc.new { |html_tag, instance|
      "<div class=\"field_with_errors control-group error\">#{html_tag}</div>".html_safe}
  end
end
