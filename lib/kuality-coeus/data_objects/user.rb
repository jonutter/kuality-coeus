class UserObject

  include Foundry
  include DataFactory

  attr_accessor :user_name, :role

  DEFAULT_USERS = {
    # Syntax:
    # :user=>hash_of_user_settings
    #
    # Note: Except in the "custom" situation,
    # please make the Key for the user hash
    # match the role value, snake-ified, of
    # course.
    #
    :admin=>{
        role: 'admin',
        user_name: 'admin'
    },
    :custom=>{}
  }

  def initialize(browser, opts={})
    @browser = browser
    opts[:user]=:admin if opts[:user]==nil
    defaults = DEFAULT_USERS[opts[:user]]
    set_options defaults.merge(opts)
  end

  def sign_in
    if logged_out?
      user_login
    else # Log the current user out, then log in
      log_out
      user_login
    end
  end
  alias_method :log_in, :sign_in

  def logged_in?
    if login_info.exists?
      login_info.text=~/#{@user_name}/ ? true : false
    else
      false
    end
  end
  alias_method :signed_in?, :logged_in?

  def logged_out?
    !logged_in?
  end
  alias_method :signed_out?, :logged_out?

  def log_out
    s_o.click if s_o.present?
  end
  alias_method :sign_out, :log_out

  #========
  private
  #========

  def user_login
    visit Login do |log_in|
      log_in.username.set @user_name
      log_in.login
    end
  end

  def s_o
    @browser.button(value: 'Logout')
  end

  def login_info
    @browser.div(id: 'login-info')
  end

end