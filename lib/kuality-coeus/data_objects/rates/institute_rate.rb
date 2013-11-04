class InstituteRateObject < DataObject

  include StringFactory
  include DateFactory
  include Navigation

  ACTIVITY_TYPES = {
    # Description                   # Code
      'Research'                   => '1',
      'Instruction'                => '2',
      'Public Service'             => '3',
      'Clinical Trial'             => '4',
      'other'                      => '5',
      'Fellowship - Pre-Doctoral'  => '6',
      'Fellowship - Post-Doctoral' => '7',
      'Student Services'           => '8',
      'Construction'               => '9'
  }

  RATE_CLASS_TYPES = {
      'E' => 'Fringe Benefits',
      'I' => 'Inflation',
      'L' => 'Lab Allocation - Other',
      'O' => 'F & A',
      'V' => 'Vacation',
      'X' => 'Other',
      'Y' => 'Lab Allocation - Salaries'
  }

  RATE_CLASS_CODES = {
      'MTDC'                              => '1',
      'Lab Allocation - Salaries'         => '10',
      'Lab Allocation - M&S'              => '11',
      'Lab Allocation - Utilities'        => '12',
      'MTDC - AWARD'                      => '13',
      'TDC'                               => '2',
      'S&W'                               => '3',
      'Fund with Transaction Fee (FUNSN)' => '4',
      'Employee Benefits'                 => '5',
      'Inflation'                         => '7',
      'Vacation'                          => '8',
      'Other'                             => '9'
  }

  RATE_TYPES = {
      'MTDC'=>{class: '1', type: '1'},
      'Lab Allocation - Salaries'=>{class: '10', type: '1'},
      'Lab Allocation - M&S'=>{class: '11', type: '1'},
      'Lab Allocation - Utilities'=>{class: '12', type: '1'},
      'MTDC - Award'=>{class: '13', type: '1'},
      'FUNSN'=>{class: '13', type: '10'},
      'FUNNX'=>{class: '13', type: '11'},
      'FUNSNX'=>{class: '13', type: '12'},
      'FUNSAX'=>{class: '13', type: '13'},
      'FUNNXF'=>{class: '13', type: '14'},
      'FUNMNX'=>{class: '13', type: '15'},
      'FUNMFX'=>{class: '13', type: '16'},
      'SLNSN'=>{class: '13', type: '17'},
      'SLNMN'=>{class: '13', type: '18'},
      'SLNMF'=>{class: '13', type: '19'},
      'TDC - DO NOT USE'=>{class: '13', type: '2'},
      'GENSN'=>{class: '13', type: '20'},
      'GENSNF'=>{class: '13', type: '21'},
      'RESSN'=>{class: '13', type: '22'},
      'FUNSAN'=>{class: '13', type: '23'},
      'FUNFN'=>{class: '13', type: '24'},
      'RESTDC'=>{class: '13', type: '25'},
      'FUNTDC'=>{class: '13', type: '26'},
      'RESTG'=>{class: '13', type: '27'},
      'RESTDE'=>{class: '13', type: '28'},
      'BIMN'=>{class: '13', type: '29'},
      'Other'=>{class: '13', type: '3'},
      'None'=>{class: '13', type: '4'},
      'RESMN'=>{class: '13', type: '5'},
      'RESMF'=>{class: '13', type: '6'},
      'EXCLU'=>{class: '13', type: '7'},
      'RESEB'=>{class: '13', type: '8'},
      'RESMFF'=>{class: '13', type: '9'},
      'TDC'=>{class: '2', type: '1'},
      'S&W'=>{class: '3', type: '1'},
      'Salaries'=>{class: '4', type: '1'},
      'Materials and Services'=>{class: '4', type: '2'},
      'Research Rate'=>{class: '5', type: '1'},
      'UROP Rate'=>{class: '5', type: '2'},
      'EB on LA'=>{class: '5', type: '3'},
      'another EB rate'=>{class: '5', type: '4'},
      'eb added in pb'=>{class: '5', type: '5'},
      'Award Special EB Rate'=>{class: '5', type: '6'},
      'Faculty Salaries (6/1)'=>{class: '7', type: '1'},
      'Administrative Salaries (7/1)'=>{class: '7', type: '2'},
      'Support Staff Salaries (4/1)'=>{class: '7', type: '3'},
      'Materials and Services'=>{class: '7', type: '4'},
      'Research Staff (1/1)'=>{class: '7', type: '5'},
      'Students (6/1)'=>{class: '7', type: '6'},
      'Vacation'=>{class: '8', type: '1'},
      'Vacation on LA'=>{class: '8', type: '2'},
      'Other'=>{class: '9', type: '1'}
  }

  attr_accessor :activity_type, :activity_type_code, :fiscal_year, :on_off_campus_flag,
                :rate_type, :rate_class_code, :rate_type_code, :start_date, :unit_number,
                :rate, :active, :description

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      description: random_alphanums,
      fiscal_year: right_now[:year],
      activity_type: 'Instruction',
      on_off_campus_flag: :set,
      rate_type: 'Salaries',
      unit_number: '000001',
      rate: "#{rand(9)+1}.#{rand(100)}",
      active: :set
    }

    set_options(defaults.merge(opts))
    @start_date ||= "01/01/#{@fiscal_year}"
    @activity_type_code = ACTIVITY_TYPES[@activity_type]
    @rate_class_code = RATE_TYPES[@rate_type][:class]
    @rate_type_code = RATE_TYPES[@rate_type][:type]
  end

  def create
    navigate
    on(InstituteRatesLookup).create_new
    on InstituteRatesMaintenance do |create|
      fill_out create, :description, :activity_type_code, :fiscal_year,
               :rate_class_code, :rate_type_code, :start_date, :unit_number,
               :rate, :on_off_campus_flag, :active
      create.blanket_approve
    end
  end

  def exist?
    $users.admin.log_in if $users.current_user==nil
    navigate
    search
    if on(InstituteRatesLookup).results_table.present?
      return true
    else
      return false
    end
  end

  # This method...
  # - Breaks the CRUD model and the design pattern, but is necessary because of how the system
  #   restricts creation of rate records
  # - Assumes it doesn't need to navigate because it's being used
  #   in very specific places
  def get_current_rate
    on(InstituteRatesLookup).edit_item "#{@activity_type}.#{@fiscal_year}.+#{@rate_type}"
    @rate=on(InstituteRatesMaintenance).rate.value
  end

  # This method...
  # - Breaks the CRUD model and the design pattern, but is necessary because of how the system
  #   restricts creation of rate records
  # - Assumes it doesn't need to navigate  because it's being used
  #   in very specific places
  def activate
    @active=:set
    on InstituteRatesMaintenance do |edit|
      edit.active.send(@active)
      fill_out edit, :description
      edit.blanket_approve
    end
  end

  def delete
    navigate
    search
    on(InstituteRatesLookup).delete_item "#{@rate_type}"
    on InstituteRatesMaintenance do |del|
      del.description.set @description
      del.blanket_approve
    end
  end

  def search
    on InstituteRatesLookup do |look|
      fill_out look, :activity_type_code, :fiscal_year, :rate_class_code,
               :rate_type_code, :unit_number
      look.on_off_campus campus_lookup[@on_off_campus_flag]
      look.active ''
      look.search
    end
  end

  # =========
  private
  # =========

  def navigate
    # TODO: Throw some conditional logic in here so that we don't navigate every time.
    visit Maintenance do |page|
      page.close_parents
      page.institute_rate
    end
  end

  def campus_lookup
    { :set=>'Y', :clear=>'N' }
  end
  alias_method :active_lookup, :campus_lookup

end