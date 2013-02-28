class KeyPersonnel < ProposalDevelopmentDocument

  proposal_header_elements

  action(:employee_search) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.bo.KcPerson!!).(((personId:newPersonId))).((``)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;;::::).anchor').click }
  action(:non_employee_search) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.bo.NonOrganizationalRolodex!!).(((rolodexId:newRolodexId))).((``)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;;::::).anchor').click }
  element(:proposal_role) { |b| b.frm.select(id: 'newProposalPerson.proposalPersonRoleId') }
  element(:key_person_role) { |b| b.frm.text_field(id: 'newProposalPerson.projectRole') }
  action(:add_person) { |b| b.frm.button(name: 'methodToCall.insertProposalPerson').click }
  action(:clear) { |b| b.frm.button(name: 'methodToCall.clearProposalPerson').click }

  value(:person_name) { |b| b.frm.table(class: 'grid')[0][1].text }

  action(:select_unit) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.bo.Unit!!).(((unitNumber:newProposalPersonUnit[0].unitNumber,unitName:newProposalPersonUnit[0].unitName))).((``)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;;::::).anchor').click }
  element(:unit_number) { |b| b.frm.text_field(id: /unitNumber/) }

  # Note this method returns a collection of Watir li objects
  element(:add_validation_errors) { |b| b.frm.div(id: 'left-errmsg-tab').div(class: 'error').lis }

  # Person info...

  # Note this is a *setting* of the person's checkbox, since this method is only used
  # in the context of deleting the person from the Personnel
  action(:check_person) { |full_name, b| b.frm.h2(text: full_name).parent.checkbox(title: 'Generic Boolean Attribute') }

  action(:show_person) { |full_name, b| b.frm.button(title: "open #{twospace(full_name)}").click }
  action(:show_person_details) { |full_name, b| b.frm.button(id: "tab-#{nsp(full_name)}:PersonDetails-imageToggle").click }

  # Note this method ONLY relates to the select list for the role, not
  # the read-only field that appears when the role is "Key Person"
  action(:role) { |full_name, p| p.person_div(full_name).select(name: /document.developmentProposalList[\d+].proposalPersons[\d+].proposalPersonRoleId/) }
  action(:user_name) { |full_name, p| p.person_div(full_name).table[1][3].text }
  action(:home_unit) { |full_name, p| p.person_div(full_name).table[5][1].text }

  action(:show_unit_details) { |full_name, b| b.frm.button(id: "tab-#{nsp(full_name)}:UnitDetails-imageToggle").click }
  action(:add_unit) { |full_name, p| p.unit_div(full_name).button(title: "Add Unit").click }

  # This returns an array of hashes, like so:
  # [{:name=>"Unit1 Name", :number=>"Unit1 Number"}, {:name=>"Unit2 Name", :number=>"Unit2 Number"}]
  action(:units) { |full_name, p| units = []; p.unit_div(full_name).table.to_a[2..-1].each { |unit| units << {name: unit[1], number: unit[2]} }; units }

  # Combined Credit Split
  action(:responsibility) { |name, b| b.credit_split_div_table.row(text: /#{name}/)[1].text_field }
  action(:financial) { |name, b| b.credit_split_div_table.row(text: /#{name}/)[2].text_field }
  action(:recognition) { |name, b| b.credit_split_div_table.row(text: /#{name}/)[3].text_field }

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

  element(:credit_split_div_table) { |b| b.frm.div(id: "tab-CombinedCreditSplit-div").table }
  action(:person_div) { |full_name, b| b.frm.div(id: "tab-#{nsp(full_name)}:PersonDetails-div") }
  action(:unit_div) { |full_name, b| b.frm.div(id: "tab-#{nsp(full_name)}:UnitDetails-div") }


end