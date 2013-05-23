class KeyPersonnel < ProposalDevelopmentDocument

  proposal_header_elements
  error_messages

  action(:employee_search) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.bo.KcPerson!!).(((personId:newPersonId))).((``)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;;::::).anchor').click }
  action(:non_employee_search) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.bo.NonOrganizationalRolodex!!).(((rolodexId:newRolodexId))).((``)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;;::::).anchor').click }
  element(:proposal_role) { |b| b.frm.select(id: 'newProposalPerson.proposalPersonRoleId') }
  element(:key_person_role) { |b| b.frm.text_field(id: 'newProposalPerson.projectRole') }
  action(:add_person) { |b| b.frm.button(name: 'methodToCall.insertProposalPerson').click }
  action(:clear) { |b| b.frm.button(name: 'methodToCall.clearProposalPerson').click }

  value(:person_name) { |b| b.frm.table(class: 'grid')[0][1].text }

  # Use to check if there are errors present or not...
  element(:add_person_errors_div) { |b| b.frm.div(class: 'annotate-container').div(class: 'left-errmsg-tab').div }

  # The catch-all container for all errors that appear on the page

  value(:add_person_errors) { |b| b.frm.div(class: 'annotate-container').div(class: 'left-errmsg-tab').divs.collect{ |div| div.text} }
  value(:add_validation_errors) { |b| b.frm.div(class: 'annotate-container').div(class: 'left-errmsg-tab', index: 1).lis.collect{ |li| li.text} }
  value(:combined_credit_split_errors) { |b| b.frm.div(id: 'tab-CombinedCreditSplit-div').div(class: 'left-errmsg-tab').divs.collect{ |div| div.text } }

  # Person info...

  # Note this is a *setting* of the person's checkbox, since this method is only used
  # in the context of deleting the person from the Personnel
  action(:check_person) { |full_name, b| b.frm.h2(text: full_name).parent.checkbox(title: 'Generic Boolean Attribute').set }

  action(:show_person) { |full_name, b| b.frm.button(title: "open #{twospace(full_name)}").click }

  # Person Details...
  action(:show_person_details) { |full_name, b| b.frm.button(id: "tab-#{nsp(full_name)}:PersonDetails-imageToggle").click }

  # Note this method ONLY relates to the select list for the role, not
  # the read-only field that appears when the role is "Key Person"
  action(:role) { |full_name, p| p.person_div(full_name).select(name: /document.developmentProposalList[\d+].proposalPersons[\d+].proposalPersonRoleId/) }
  action(:user_name) { |full_name, p| p.person_div(full_name).table[1][3].text }
  action(:home_unit) { |full_name, p| p.person_div(full_name).table[8][1].text }

  # Unit Details...
  action(:unit_details_errors_div) { |full_name, p| p.unit_div(full_name).div(class: 'left-errmsg-tab').div }
  action(:unit_details_errors) { |full_name, p| p.unit_details_errors_div(full_name).divs.collect { |div| div.text } }

  # This button is only present in the context of a Key Person...
  action(:add_unit_details) { |full_name, p| p.unit_div(full_name).button(title: 'Add Unit Details').click }

  action(:show_unit_details) { |full_name, b| b.frm.button(id: "tab-#{nsp(full_name)}:UnitDetails-imageToggle").click }
  action(:lookup_unit) { |full_name, p| p.unit_div(full_name).button(name: 'methodToCall.performLookup.(!!org.kuali.kra.bo.Unit!!).(((unitNumber:newProposalPersonUnit[0].unitNumber,unitName:newProposalPersonUnit[0].unitName))).((``)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;;::::).anchor').click }
  action(:unit_number) { |full_name, p| p.unit_div(full_name).text_field(id: /unitNumber/) }
  action(:add_unit) { |full_name, p| p.unit_div(full_name).button(title: 'Add Unit').click }
  action(:delete_unit) { |full_name, unit_number, p| p.unit_div(full_name).table(class: 'tab').row(text: /#{unit_number}/).button(title: 'Remove Unit').click }

  # This returns an array of hashes, like so:
  # [{:name=>"Unit1 Name", :number=>"Unit1 Number"}, {:name=>"Unit2 Name", :number=>"Unit2 Number"}]
  action(:units) { |full_name, p| units = []; p.unit_div(full_name).table.to_a[2..-1].each { |unit| units << {name: unit[1], number: unit[2]} }; units }

  # Proposal Person Certification
  action(:include_certification_questions) { |full_name, b| b.certification_div(full_name).button(title: 'Add Certification Question').click }
  action(:show_proposal_person_certification) {}
  # Questions...
  {
    :certify_info_true=>0,
    :potential_for_conflict=>1,
    :submitted_financial_disclosures=>2,
    :lobbying_activities=>3,
    :excluded_from_transactions=>4,
    :familiar_with_pla=>5
  }.each { |key, value| action(key) { |full_name, answer, p| p.questions_div(full_name).table(data_kc_questionindex: value.to_s).radio(value: answer).set } }

  # Combined Credit Split
  {
    'recognition'=>1,
    'responsibility'=>2,
    'space'=>3,
    'financial'=>4
  }.each do |key, value|
    # Makes methods for the person's 3 credit splits (doesn't have to take the full name of the person to work)
    # Example: page.responsibility('Joe Schmoe').set '100.00'
    action(key.to_sym) { |name, b| b.credit_split_div_table.row(text: /#{name}/)[value].text_field }
    # Makes methods for the person's units' credit splits
    # Example: page.unit_financial('Jane Schmoe', 'Unit').set '50.0'
    action("unit_#{key}".to_sym) { |full_name, unit_name, p| p.target_unit_row(full_name, unit_name)[value].text_field }
  end

  # =======
  private
  # =======

  class << self
    # Used for getting rid of the space in the full name
    def nsp(string)
      string.gsub(' ', '')
    end

    # Used to add an extra space in the full name (because some
    # elements in the page have that, annoyingly!)
    def twospace(string)
      string.gsub(' ', '  ')
    end
  end

  element(:credit_split_div_table) { |b| b.frm.div(id: 'tab-CombinedCreditSplit-div').table }

  action(:target_unit_row) do |full_name, unit_number, p|
    trows = p.credit_split_div_table.rows
    index = trows.find_index { |row| row.text=~/#{full_name}/ }
    trows[index..-1].find { |row| row.text=~/#{unit_number}/ }
  end

  action(:person_div) { |full_name, b| b.frm.div(id: "tab-#{nsp(full_name)}:PersonDetails-div") }
  action(:unit_div) { |full_name, b| b.frm.div(id: "tab-#{nsp(full_name)}:UnitDetails-div") }
  action(:questions_div) { |full_name, b| b.frm.span(class: 'subhead-left', text: full_name).parent.parent.div(class: 'questionnaireContent') }
  action(:certification_div) { |full_name, b| b.frm.div(id: "tab-#{nsp(full_name)}:Certify-div") }

end