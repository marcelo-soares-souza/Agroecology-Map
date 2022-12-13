# frozen_string_literal: true

InvisibleCaptcha.setup do |config|
  config.timestamp_threshold = 5
  config.timestamp_enabled = true
  config.spinner_enabled = true
  config.visual_honeypots = false
end
