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
  @browser = kuality.browser
  $users.clear
  # Add the admin user to the Users...
  $users << UserObject.new(@browser)
end

After do |scenario|

  if scenario.failed?
    @browser.screenshot.save 'screenshot.png'
    embed 'screenshot.png', 'image/png'
  end

  $users.current_user.sign_out unless $users.current_user==nil

end