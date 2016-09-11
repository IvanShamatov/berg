require_relative "db_helper"

require "rack/test"
require "capybara/rspec"
require "capybara-screenshot/rspec"
require "capybara/poltergeist"

Dir[SPEC_ROOT.join("support/app/*.rb").to_s].each(&method(:require))
Dir[SPEC_ROOT.join("shared/app/*.rb").to_s].each(&method(:require))

require SPEC_ROOT.join("../umbrella/system/boot").realpath

Capybara.app = Umbrella::Application.app
Capybara.server_port = 3001
Capybara.save_path = "#{File.dirname(__FILE__)}/../tmp/capybara-screenshot"
Capybara.javascript_driver = :poltergeist
Capybara::Screenshot.prune_strategy = {keep: 10}

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(
    app,
    js_errors: false,
    phantomjs_logger: File.open(SPEC_ROOT.join("../log/phantomjs.log"), "w"),
    phantomjs_options: %w(--load-images=no),
    window_size: [1600, 768]
  )
end

RSpec.configure do |config|
  config.include TestPageHelpers
  config.include Rack::Test::Methods, type: :request
  config.include Rack::Test::Methods, Capybara::DSL, type: :feature

  config.before :suite do
    required_phantomjs_version = '2.1.1'
    phantomjs_versions = `phantomjs -v`
    if Gem::Version.new(phantomjs_versions) < Gem::Version.new(required_phantomjs_version)
      puts "\e[31mWARN: Using phantomjs #{phantomjs_versions} which is < #{required_phantomjs_version}, please upgrade\e[0m"
      exit(status=false)
    end
    Umbrella::Application.freeze
  end
end
