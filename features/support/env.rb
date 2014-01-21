require 'yaml'

@config = YAML.load_file("#{File.dirname(__FILE__)}/config.yml")[:basic]

$base_url = @config[:url]

require "#{File.dirname(__FILE__)}/../../lib/kuality-coeus"
require 'rspec/matchers'

World Foundry
World StringFactory
World DateFactory
World Utilities

kuality = Kuality.new @config[:browser]

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