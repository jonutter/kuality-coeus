class Personnel < BudgetDocument

  select_budget_period
  glbl 'View Personnel Salaries'

  action(:job_code) { |person, b| b.pp_row(person).text_field(title: 'Job Code') }
  action(:appointment_type) { |person, b| b.pp_row(person).select(title: 'Appointment Type') }
  action(:base_salary) { |person, b| b.pp_row(person).text_field(title: '* Base Salary') }
  action(:salary_effective_date) { |person, b| b.pp_row(person).text_field(title: '* Salary Effective Date') }
  action(:salary_anniversary_date) { |person, b| b.pp_row(person).text_field(title: 'Salary Anniversary Date') }
  action(:delete_person) { |person, b| b.pp_row(person).button(name: /methodToCall.deleteBudgetPerson.line\d+/) }
  action(:sync_personnel) { |b| b.frm.button(name: 'methodToCall.synchToProposal').click; b.loading }

  element(:person) { |b| b.frm.select(name: 'newBudgetPersonnelDetails.personSequenceNumber') }
  element(:object_code_name) { |b| b.frm.select(name: /newBudgetLineItems[\d+].costElement/) }
  action(:add_person) { |b| b.frm.button(class: 'addButton').click; b.loading }

  action(:start_date) { |person, b| b.start_date_fields[b.find_person_index(person)] }
  action(:end_date) { |person, b| b.end_date_fields[b.find_person_index(person)] }
  action(:percent_effort) { |person, b| b.effort_fields[b.find_person_index(person)] }
  action(:percent_charged) { |person, b| b.charged_fields[b.find_person_index(person)] }
  action(:period_type) { |person, b| b.period_type_fields[b.find_person_index(person)] }
  action(:requested_salary) { |person, b| b.period_type(person).parent.parent.parent.td(index: 6).text }
  action(:calculated_fringe) { |person, b| b.period_type(person).parent.parent.parent.td(index: 7).text }
  action(:calculate) { |person, b| b.period_type(person).parent.parent.parent.button(name: /methodToCall.calculateSalary/).click; b.loading }
  action(:delete) { |person, b| b.period_type(person).parent.parent.parent.button(name: /methodToCall.deleteBudgetPersonnelDetails/).click; b.loading }

  action(:budget_category) { |person, b| b.budget_category_fields[b.find_person_index(person)] }
  action(:number_of_persons) { |person, b| b.num_persons_fields[b.find_person_index(person)] }
  action(:on_off_campus) { |person, b| b.on_off_campus_fields[b.find_person_index(person)] }
  action(:submit_cost_sharing) { |person, b| b.submit_cost_sharing_fields[b.find_person_index(person)] }

  # ========
  private
  # ========

  element(:project_personnel_table) { |b| b.frm.table(id: 'budget-personnel-table') }
  action(:pp_row) { |person, b| b.project_personnel_table.row(text: /#{person}/) }
  element(:budget_overview_table) { |b| b.frm.div(id: /tab-BudgetOverviewPeriod\d+-div/).div(class: 'tab-container').table }
  element(:personnel_detail_tab) { |b| b.frm.div(id: /tab-PersonnelDetailPeriod\d+-div/) }
  element(:person_rows) { |b| b.personnel_detail_tab.divs(text: /\A\s*\d+\s*\z/, align: 'center') }
  element(:start_date_fields) { |b| b.frm.text_fields(title: '* Start Date') }
  element(:end_date_fields) { |b| b.frm.text_fields(title: '* End Date') }
  element(:effort_fields) { |b| b.frm.text_fields(title: '% Effort') }
  element(:charged_fields) { |b| b.frm.text_fields(title: '% Charged') }
  element(:period_type_fields) { |b| b.frm.selects(class: 'Period Type') }
  element(:budget_category_fields) { |b| b.frm.selects(title: 'Budget Category') }
  element(:num_persons_fields) { |b| b.frm.text_fields(title: 'Quantity') }
  element(:on_off_campus_fields) { |b| b.frm.checkboxes(title: 'On/Off Campus') }
  element(:submit_cost_sharing_fields) { |b| b.frm.checkboxes(title: 'Submit Cost Sharing?') }

  value(:persons_list) { |b| b.person_rows.collect{ |row| row.parent.parent.td.text} }

  action(:find_person_index) { |person, b| b.persons_list.find_index{ |item| item.include? person } }

end