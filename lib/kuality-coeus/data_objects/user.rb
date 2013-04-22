class UserObject

  include Foundry
  include DataFactory

  attr_accessor :user_name,
                :first_name, :last_name,
                :description, :affiliation_type, :campus_code,
                :employee_id, :employee_status, :employee_type, :base_salary,
                :groups, :roles, :role_qualifiers

  DEFAULT_USERS = YAML.load_file("#{File.dirname(__FILE__)}/users.yml")

  def initialize(browser, opts={})
    @browser = browser
    opts[:user]=:admin if opts[:user]==nil
    defaults = DEFAULT_USERS[opts[:user]]
    set_options defaults.merge(opts)
  end

  def create
    visit(SystemAdmin).person
    on(PersonLookup).create
    on Person do |add|
      add.expand_all
      add.principal_name.set @user_name
      fill_out add, :description, :affiliation_type, :campus_code, :first_name, :last_name
      # TODO: These "default" checkboxes will need to be reworked if and when
      # a test is going to require multiple affiliations, names, addresses, etc.
      # Until then, there's no need to do anything other than set the necessary single values
      # as "default"...
      add.affiliation_default.set
      add.name_default.set
      add.add_affiliation
      fill_out add, :employee_id, :employee_status, :employee_type, :base_salary
      add.add_employment_information
      add.add_name
      @roles.each do |role|
        add.role_id.set role
        add.add_role
      end
      @groups.each do |group|
        add.group_id.set group
        add.add_group
      end
      @role_qualifiers.each do |role, unit|
        add.unit_number(role).set unit
        add.add_role_qualifier
      end
      add.blanket_approve
    end
  end

  def sign_in
    visit Login { |log_in|
      log_in.username.set @user_name
      log_in.login
    } unless logged_in?
  end
  alias_method :log_in, :sign_in

  def sign_out
  # This _might_ cause an infinite loop, but I'm
  # hoping not...
    on(Researcher) do |page|
      page.return_to_portal
      page.close_children
    end
    if s_o.present?
      s_o.click
    else
      visit Login do |page|
        if page.username.present?
          # do nothing because we're already logged out...
        else
          log_out
        end
      end
    end
  end
  alias_method :log_out, :sign_out

  def exist?
    visit(SystemAdmin).person
    on PersonLookup do |search|
      search.principal_id.set @user_name
      search.search
      search.results_table.present?
    end
  end
  alias_method :exists?, :exist?

  #========
  private
  #========

  def logged_in?
    begin
      on(Researcher).return_to_portal
    rescue
      visit(Login).close_children
      @browser.windows[0].use
    end
    if login_info_div.present?
      login_info_div.text.include? @user_name ? true : false
    else
      false
    end
  end

  def s_o
    @browser.button(value: 'Logout')
  end

  def login_info_div
    @browser.div(id: 'login-info')
  end

end