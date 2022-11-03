# frozen_string_literal: true

require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Agroecologia
  class Application < Rails::Application
    config.load_defaults 5.1

    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.log_tags  = [:subdomain, :uuid]
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
    #    config.generators.javascript_engine = :js

    config.generators do |g|
      g.template_engine nil
      g.test_framework  nil
      g.assets false
      g.helper false
      g.stylesheets false
    end
  end
end
