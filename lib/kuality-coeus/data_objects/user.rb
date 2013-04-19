class UserObject

  include Foundry
  include DataFactory

  attr_accessor :user_name, :role, :logged_in

  DEFAULT_USERS = YAML.load_file("#{File.dirname(__FILE__)}/users.yml")

  def initialize(browser, opts={})
    @browser = browser
    opts[:user]=:admin if opts[:user]==nil
    defaults = DEFAULT_USERS[opts[:user]]
    exit
    set_options defaults.merge(opts)
  end

  def create

  end

  def sign_in
    log_out
    login
  end
  alias_method :log_in, :sign_in

  alias_method :signed_in, :logged_in

  def logged_out
    !@logged_in
  end
  alias_method :signed_out, :logged_out

  def logged_in?
    @logged_in
  end
  alias_method :signed_in?, :logged_in?

  def logged_out?
    logged_out
  end
  alias_method :signed_out?, :logged_out?

  def log_out
  # This _might_ cause an infinite loop, but I'm
  # hoping not...
    if s_o.present?
      s_o.click
    else
      visit Login do |page|
        if page.username.present?
          # do nothing
        else
          log_out
        end
      end
    end
    @logged_in = false
  end
  alias_method :sign_out, :log_out

  #========
  private
  #========

  def login
    unless logged_in?
      visit Login do |log_in|
        log_in.username.set @user_name
        log_in.login
      end
      @logged_in=true
    end
  end

  def s_o
    @browser.button(value: 'Logout')
  end

end