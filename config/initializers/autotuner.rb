# frozen_string_literal: true

Autotuner.enabled = true

Autotuner.reporter = proc do |report|
  Rails.logger.info(report.to_s)
end
