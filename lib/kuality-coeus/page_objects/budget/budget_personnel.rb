class BudgetPersonnel < BudgetDocument

  select_budget_period
  glbl 'View Personnel Salaries'

  action(:employee_search) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.bo.KcPerson!!).((``)).(:;newBudgetPersons;:).((%true%)).((~~)).anchor').click }
  action(:non_employee_search) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.bo.NonOrganizationalRolodex!!).((``)).(:;newBudgetRolodexes;:).((%true%)).((~~)).anchor').click }
  action(:to_be_named_search) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.budget.personnel.TbnPerson!!).((``)).(:;newTbnPersons;:).((%true%)).((~~)).anchor').click }

  action(:job_code) { |person, b| b.pp_row(person).text_field(title: 'Job Code') }
  action(:lookup_job_code) { |person, b| b.pp_row(person).button(name: /methodToCall.performLookup/).click }
  action(:appointment_type) { |person, b| b.pp_row(person).select(title: 'Appointment Type') }
  action(:base_salary) { |person, b| b.pp_row(person).text_field(title: '* Base Salary') }
  action(:salary_effective_date) { |person, b| b.pp_row(person).text_field(title: '* Salary Effective Date') }
  action(:salary_anniversary_date) { |person, b| b.pp_row(person).text_field(title: 'Salary Anniversary Date') }
  action(:delete_person) { |person, b| b.pp_row(person).button(name: /methodToCall.deleteBudgetPerson.line\d+/) }
  action(:sync_personnel) { |b| b.frm.button(name: 'methodToCall.synchToProposal').click; b.loading }

  element(:person) { |b| b.frm.select(name: 'newBudgetPersonnelDetails.personSequenceNumber') }
  element(:object_code_name) { |b| b.frm.select(name: 'newBudgetLineItems[0].costElement') }
  action(:add_details) { |b| b.frm.button(class: 'addButton').click; b.loading }

  action(:start_date) { |person, b| b.pd_row(person).text_field(title: '* Start Date') }
  action(:end_date) { |person, b| b.pd_row(person).text_field(title: '* End Date') }
  action(:percent_effort) { |person, b| b.pd_row(person).text_field(title: '% Effort') }
  action(:percent_charged) { |person, b| b.pd_row(person).text_field(title: '% Charged') }
  action(:period_type) { |person, b| b.pd_row(person).select(title: 'Period Type') }
  action(:requested_salary) { |person, b| b.pd_row(person).td(index: 7).text }
  action(:calculated_fringe) { |person, b| b.pd_row(person).td(index: 8).text }
  action(:calculate) { |person, b| b.pd_row(person).button(name: /methodToCall.calculateSalary/).click; b.loading }
  action(:delete) { |person, b| b.pd_row(person).button(name: /methodToCall.deleteBudgetPersonnelDetails/).click; b.loading }

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
  action(:pd_row) { |person, b| b.personnel_detail_tab.div(id: /tab-\d+-div/).tr(text: /#{person}/) }

end