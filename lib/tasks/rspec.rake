# frozen_string_literal: true

namespace :test do
  task :rspec do
    Rake::Task["spec"].invoke
  end
end
