require 'singleton'
require 'test-factory'
require 'date'
require 'yaml'
Dir["#{File.dirname(__FILE__)}/kuality-coeus/*.rb"].alphabetize.each {|f| require f }
Dir["#{File.dirname(__FILE__)}/kuality-coeus/page_objects/*.rb"].alphabetize.each {|f| require f }
Dir["#{File.dirname(__FILE__)}/kuality-coeus/page_objects/*/*.rb"].alphabetize.each {|f| require f }
Dir["#{File.dirname(__FILE__)}/kuality-coeus/data_objects/*.rb"].alphabetize.each {|f| require f }
Dir["#{File.dirname(__FILE__)}/kuality-coeus/data_objects/*/*.rb"].alphabetize.each {|f| require f }

# Initialize this class at the start of your test cases to
# open the specified test browser at the specified welcome page URL.
#
# The initialization will
# create the browser object that can be used throughout the page classes
class Kuality

  attr_reader :browser

  def initialize(web_browser)
    if web_browser == :saucelabs
      @browser = Watir::Browser.new(
          :remote,
          :url => "http://#{ENV['username']}:#{ENV['api_key']}@ondemand.saucelabs.com:80/wd/hub",
          :desired_capabilities => $environment
      )
    else
      @browser = Watir::Browser.new web_browser
      @browser.window.resize_to(1400,900)
    end
    @browser.goto $base_url
  end

end