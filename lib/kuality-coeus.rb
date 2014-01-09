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
# - Create the browser object that can be used throughout the page classes
# - Create the $users collection for storing User objects needed for scenarios
# - Set the file folder location, for tests that require uploading of files
# - Define the base_url that will be used throughout the page classes for ease of navigation
class Kuality

  attr_reader :browser

  def initialize(web_browser, base_url)
    $base_url = base_url
    $users = Users.instance
    $file_folder = "#{File.dirname(__FILE__)}/resources/"

    @browser = Watir::Browser.new web_browser
    @browser.window.resize_to(1400,900)
    @browser.goto $base_url

  end

end