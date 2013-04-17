class UserObject

  include Foundry
  include DataFactory

  attr_accessor :user_name, :role, :logged_in

  DEFAULT_USERS = {
    # Syntax:
    # :user=>hash_of_user_settings
    #
    # Note: When you are adding a
    # canned user type to this list, then,
    # except in the "custom" situation,
    # please make the Key for the user hash
    # match the role value, snake-ified, of
    # course.
    #
    :admin=>{
        role: 'admin',
        user_name: 'admin'
    },
    :aggregator=>{
        role: 'aggregator',
        user_name: 'jutter'
    },
    :custom=>{}
  }

  def initialize(browser, opts={})
    @browser = browser
    # TODO: This syntax is in dire need of improvement...
    opts[:user]=:admin if opts[:user]==nil
    defaults = DEFAULT_USERS[opts[:user]]
    set_options defaults.merge(opts)
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