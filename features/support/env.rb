# this is from /var/lib/jenkins/.rvm/gems/ruby-1.9.3-p448/gems/kuality-coeus-0.0.4/features/support/env.rb
require 'yaml'
require 'watir-webdriver'

config = YAML.load_file("#{File.dirname(__FILE__)}/config.yml")
basic = config[:basic]

$base_url = basic[:url]
$context = basic[:context]
$file_folder = "#{File.dirname(__FILE__)}/../../lib/resources/"

$cas = config[:cas]
$cas_context = config[:cas_context]

if config[:headless]
  require 'headless'
  headless = Headless.new
  headless.start
end

require "#{File.dirname(__FILE__)}/../../lib/kuality-coeus"
require 'rspec/matchers'

World Foundry
World StringFactory
World DateFactory
World Utilities

kuality = Kuality.new basic[:browser]

Before do
  # Get the browser object
  @browser = kuality.browser
  # Clean out any users that might exist
  $users.clear
  # Add the admin user to the Users...
  $users << UserObject.new(@browser)
end

After do |scenario|
  # Grab a screenshot
  if scenario.failed?
    @browser.screenshot.save 'screenshot.png'
    embed 'screenshot.png', 'image/png'
  end
  # Log out if not already
  $users.current_user.sign_out unless $users.current_user==nil
end

at_exit { kuality.browser.close }