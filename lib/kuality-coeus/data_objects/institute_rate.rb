class InstituteRateObject

  include Foundry
  include DataFactory
  include StringFactory
  include DataFactory
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

  RATE_TYPES = [
    {class: '1', type: '1', description: 'MTDC'},
    {class: '10', type: '1', description: 'Lab Allocation - Salaries'},
    {class: '11', type: '1', description: 'Lab Allocation - M&S'},
    {class: '12', type: '1', description: 'Lab Allocation - Utilities'},
    {class: '13', type: '1', description: 'MTDC - Award'},
    {class: '13', type: '10', description: 'FUNSN'},
    {class: '13', type: '11', description: 'FUNNX'},
    {class: '13', type: '12', description: 'FUNSNX'},
    {class: '13', type: '13', description: 'FUNSAX'},
    {class: '13', type: '14', description: 'FUNNXF'},
    {class: '13', type: '15', description: 'FUNMNX'},
    {class: '13', type: '16', description: 'FUNMFX'},
    {class: '13', type: '17', description: 'SLNSN'},
    {class: '13', type: '18', description: 'SLNMN'},
    {class: '13', type: '19', description: 'SLNMF'},
    {class: '13', type: '2', description: 'TDC - DO NOT USE'},
    {class: '13', type: '20', description: 'GENSN'},
    {class: '13', type: '21', description: 'GENSNF'},
    {class: '13', type: '22', description: 'RESSN'},
    {class: '13', type: '23', description: 'FUNSAN'},
    {class: '13', type: '24', description: 'FUNFN'},
    {class: '13', type: '25', description: 'RESTDC'},
    {class: '13', type: '26', description: 'FUNTDC'},
    {class: '13', type: '27', description: 'RESTG'},
    {class: '13', type: '28', description: 'RESTDE'},
    {class: '13', type: '29', description: 'BIMN'},
    {class: '13', type: '3', description: 'Other'},
    {class: '13', type: '4', description: 'None'},
    {class: '13', type: '5', description: 'RESMN'},
    {class: '13', type: '6', description: 'RESMF'},
    {class: '13', type: '7', description: 'EXCLU'},
    {class: '13', type: '8', description: 'RESEB'},
    {class: '13', type: '9', description: 'RESMFF'},
    {class: '2', type: '1', description: 'TDC'},
    {class: '3', type: '1', description: 'S&W'},
    {class: '4', type: '1', description: 'Salaries'},
    {class: '4', type: '2', description: 'Materials and Services'},
    {class: '5', type: '1', description: 'Research Rate'},
    {class: '5', type: '2', description: 'UROP Rate'},
    {class: '5', type: '3', description: 'EB on LA'},
    {class: '5', type: '4', description: 'another EB rate'},
    {class: '5', type: '5', description: 'eb added in pb'},
    {class: '5', type: '6', description: 'Award Special EB Rate'},
    {class: '7', type: '1', description: 'Faculty Salaries (6/1)'},
    {class: '7', type: '2', description: 'Administrative Salaries (7/1)'},
    {class: '7', type: '3', description: 'Support Staff Salaries (4/1)'},
    {class: '7', type: '4', description: 'Materials and Services'},
    {class: '7', type: '5', description: 'Research Staff (1/1)'},
    {class: '7', type: '6', description: 'Students (6/1)'},
    {class: '8', type: '1', description: 'Vacation'},
    {class: '8', type: '2', description: 'Vacation on LA'},
    {class: '9', type: '1', description: 'Other'}
  ]

  attr_accessor :activity_type_code, :fiscal_year, :on_off_campus_flag,
                :rate_class_code, :rate_type_code, :start_date, :unit_number,
                :rate, :active, :description

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      description: random_alphanums,
      fiscal_year: right_now[:year],
      activity_type_code: '1',
      on_off_campus_flag: :set,

    }

    set_options(defaults.merge(opts))
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

  # =========
  private
  # =========

  def navigate
    visit Maintenance do |page|
      page.close_parents
      page.institute_rate
    end
  end

end