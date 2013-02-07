class UserObject

  include Foundry
  include DataFactory

  attr_accessor :name, :username, :email, :password, :role

  def initialize(browser, opts={})
    @browser = browser
    defaults = {
        #name:     "Tester Ten",
        username: "admin",
        #email:    "test10@customer1.herokuapp.com",
        #password: "test10"
    }
    set_options defaults.merge(opts)
  end

  def edit opts={}

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
    if login_info.present?
      login_info.text=~/#{@name}/ ? true : false
    else
      false
    end
  end

  def logged_out?
    !logged_in?
  end

  def log_out
    s_o.click if s_o.present?
  end
  alias_method :sign_out, :log_out

  #========
  private
  #========

  def user_login
    visit Login do |log_in|
      log_in.username.set @name
      log_in.login
    end
  end

  def s_o
    @browser.button(value: "Logout")
  end

  def login_info
    @browser.div(id: "login-info")
  end

end