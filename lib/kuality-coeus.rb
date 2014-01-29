require 'singleton'
require 'test-factory'
require 'date'
require 'yaml'
require 'watir-webdriver'
require 'watir-nokogiri'
require 'open-uri'
Dir["#{File.dirname(__FILE__)}/kuality-coeus/*.rb"].alphabetize.each {|f| require f }
Dir["#{File.dirname(__FILE__)}/kuality-coeus/page_objects/*.rb"].alphabetize.each {|f| require f }
Dir["#{File.dirname(__FILE__)}/kuality-coeus/page_objects/*/*.rb"].alphabetize.each {|f| require f }
Dir["#{File.dirname(__FILE__)}/kuality-coeus/data_objects/*.rb"].alphabetize.each {|f| require f }
Dir["#{File.dirname(__FILE__)}/kuality-coeus/data_objects/*/*.rb"].alphabetize.each {|f| require f }

# Initialize this class at the start of your test cases to
# open the specified test browser at the specified welcome page URL.
#
# The initialization will
# - Create the @browser object that will be used throughout the page classes
# - Create the $users collection for storing User objects needed for scenarios
# - Set the $file_folder location, where files are stored for tests that require uploading of files
class Kuality

  attr_reader :browser

  def initialize(web_browser)

    @browser = Watir::Browser.new web_browser
    @browser.window.resize_to(1500,1000)
    @browser.goto $base_url

    $users       = Users.instance
    $file_folder = "#{File.dirname(__FILE__)}/resources/"

  end

end