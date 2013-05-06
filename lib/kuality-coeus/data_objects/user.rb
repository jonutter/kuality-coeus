class UserCollection < Hash

  def have_role(role)
    self.find_all{|user| user[1][:roles] != nil && user[1][:roles].include?(role)}.shuffle
  end

end

class UserObject

  include Foundry
  include DataFactory
  include Navigation

  attr_accessor :user_name,
                :first_name, :last_name,
                :description, :affiliation_type, :campus_code,
                :employee_id, :employee_status, :employee_type, :base_salary,
                :groups, :roles, :role_qualifiers,
                :address_type, :line_1, :city, :state, :country,
                :phone_type, :phone_number

  USERS = UserCollection[YAML.load_file("#{File.dirname(__FILE__)}/users.yml")]

  ROLES = {
      # Add roles here as needed for testing...
      'Aggregator'                      => '110',
      'approver'                        => '103',
      'Award Budget Aggregator'         => '113',
      'Award Budget Approver'           => '112',
      'Award Budget Modifier'           => '102',
      'Award Budget Viewer'             => '101',
      'Award Viewer'                    => '123',
      'Budget Creator'                  => '108',
      'Create Proposal Log'             => '140',
      'Departments Awards Viewer'       => '121',
      'IACUC Protocol Aggregator'       => '1421',
      'IACUC Protocol Approver'         => '1638',
      'Institutional Proposal Viewer'   => '118',
      'IRB Administrator'               => '128',
      'IRB Approver'                    => '99',
      'IRB Reviewer'                    => '127',
      'KC Super User'                   => '177',
      'Maintain IRB Questionnaire'      => '161',
      'Maintain Proposal Questionnaire' => '162',
      'Manager'                         =>  '98',
      'Narrative Writer'                => '109',
      'Negotiation Creator'             => '1382',
      'OSP Administrator'               => '131',
      'OSPApprover'                     => '100',
      'Protocol Aggregator'             => '105',
      'Proposal Creator'                => '111',
      'System User'                     => '90',
      'Unassigned'                      => '106',
      'Viewer'                          => '107',
      'View Subaward'                   => '1409',
      'View Proposal Log'               => '142'
  }

  def initialize(browser, opts={})
    @browser = browser
    @user_name=case
      when opts.empty?
        'admin'
      when opts.key?(:user)
        opts[:user]
      when opts.key?(:role)
        USERS.have_role(ROLES[opts[:role]])[0][0]
    end
    defaults = USERS[@user_name]
    defaults.nil? ? options=opts : options=defaults.merge(opts)
    set_options options
  end

  def create
    visit(SystemAdmin).person unless PersonLookup.new(@browser).principal_id.present?
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
      add.add_name
      add.add_affiliation
      # TODO: Another thing that will need to be changed if ever there's a need to test multiple
      # lines of employment:
      unless @employee_id.nil?
        fill_out add, :employee_id, :employee_status, :employee_type, :base_salary
        add.primary_employment.set
        add.add_employment_information
      end
      unless @roles.nil?
        @roles.each do |role|
          add.role_id.set role
          add.add_role
        end
      end
      unless @role_qualifiers.nil?
        puts @role_qualifiers.inspect
        @role_qualifiers.each do |role, unit|
          add.unit_number(role).set unit
          add.add_role_qualifier role
        end
      end
      unless @groups.nil?
        @groups.each do |group|
          add.group_id.set group
          add.add_group
        end
      end
      unless @line_1.nil?
        fill_out add, :address_type, :line_1, :line_2, :line_3, :city, :state, :country
        add.address_default.set
        add.add_address
      end
      unless @phone_number.nil?
        fill_out add, :phone_type, :phone_number
        add.phone_default.set
        add.add_phone
      end
      add.blanket_approve
    end
  end

  # Keep in mind...
  # - This method does nothing if the user
  #   is already logged in
  # - If some other user is logged in, they
  #   will be automatically logged out
  # - This method will close all child
  #   tabs/windows and return to the window
  #   with the header frame, so it can see
  #   who is currently logged in
  def sign_in
    unless logged_in?
      if username_field.present?
        # Do nothing because we're already there
      else
        visit Researcher do |page|
          page.return_to_portal
          page.close_children
          page.logout
        end
      end
      on Login do |log_in|
        log_in.username.set @user_name
        log_in.login
      end
      on(Researcher).logout_button.wait_until_present
    end
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
          sign_out
        end
      end
    end
  end
  alias_method :log_out, :sign_out

  def exist?
    visit(SystemAdmin).person
    on PersonLookup do |search|
      search.principal_name.set @user_name
      search.search
      return search.results_table.present? #TODO: Make this a little more robust, as there's a slim chance for a false positive
    end
  end
  alias_method :exists?, :exist?

  def logged_in?
    # Are we on the login page already?
    if username_field.present?
      # Yes! So, we're not logged in...
      false
    # No, the Kuali header is showing...
    elsif login_info_div.present?
      # So, is the user currently listed as logged in?
      return login_info_div.text.include? @user_name
    else # We're on some page that has no Kuali header, so...
      begin
        # We'll assume that the portal window exists, and go to it.
        on(Researcher).return_to_portal
      # Oops. Apparently there's no portal window, so...
      rescue
        # We'll close any extra tabs/windows
        visit(Login).close_children if @browser.windows.size > 1
        # And make sure that we're using the "parent" window
        @browser.windows[0].use
      end
      # Now that things are hopefully in a clean state, we'll start
      # the process again...
      logged_in?
    end
  end

  def logged_out?
    !logged_in?
  end

  #========
  private
  #========

  def s_o
    @browser.button(value: 'Logout')
  end

  def login_info_div
    @browser.div(id: 'login-info')
  end

  def username_field
    Login.new(@browser).username
  end

end

