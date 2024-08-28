# frozen_string_literal: true

class CleanupJob
  include Sidekiq::Job

  def perform(*_args)
    puts "Cleaning..."
  end
end
