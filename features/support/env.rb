# this is from /var/lib/jenkins/.rvm/gems/ruby-1.9.3-p448/gems/kuality-coeus-0.0.4/features/support/env.rb
require 'yaml'
require 'watir-webdriver'

config = YAML.load_file("#{File.dirname(__FILE__)}/config.yml")
basic = config[:basic]

$base_url = basic[:url]
$file_folder = "#{File.dirname(__FILE__)}/../../lib/resources/"

if config[:headless]=='yes'
  require 'headless'
  headless = Headless.new
  headless.start
end

unless config[:cas_login].nil?
  visit CasLogin do |login|
    login.username.set config[:cas_login]
    login.login
  end
end

require "#{File.dirname(__FILE__)}/../../lib/kuality-coeus"
require 'rspec/matchers'

World Foundry
World StringFactory
World DateFactory
World Utilities

kuality = Kuality.new basic[:browser]

Before do
  @browser = kuality.browser
end