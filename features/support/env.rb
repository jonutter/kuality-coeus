require 'yaml'

@config = YAML.load_file("#{File.dirname(__FILE__)}/config.yml")[:basic]

$base_url = @config[:url]

if @config[:browser]==:saucelabs
  sauce = YAML.load_file("#{File.dirname(__FILE__)}/config.yml")[:saucelabs]
  platforms = sauce[:platforms]
  platform = platforms[rand(platforms.size)]
  ENV['username'] = sauce[:username]
  ENV['api_key'] = sauce[:api_key]
  $environment = Selenium::WebDriver::Remote::Capabilities.send(platform[:browser])
  $environment.platform = platform[:os]
  $environment.version = platform[:version]
  $environment[:name] = "Testing #{platform[:browser].to_s.capitalize} on #{platform[:os]}"
end

require "#{File.dirname(__FILE__)}/../../lib/kuality-coeus"
require 'rspec/matchers'

World Foundry
World StringFactory
World DateFactory
World Utilities

kuality = Kuality.new @config[:browser]

Before do
  @browser = kuality.browser
end

# Comment out to help with debugging...
# at_exit { kuality.browser.close }