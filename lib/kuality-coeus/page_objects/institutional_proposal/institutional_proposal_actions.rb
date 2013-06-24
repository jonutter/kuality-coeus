class InstitutionalProposalActions < KCInstitutionalProposal

  inst_prop_header_elements
  route_log

  # TODO: Move these into the base page and fix up all actions pages to use them...

  element(:validation_button) { |b| b.frm.button(name: 'methodToCall.activate') }
  action(:turn_on_validation) { |b| b.validation_button.click; b.special_review_button.wait_until_present }

  def validation_errors_and_warnings
    errs = []
    validation_err_war_fields.each { |field| errs << field.html[/(?<=>).*(?=<)/] }
    errs
  end

  # =======
  private
  # =======

  element(:validation_err_war_fields) { |b| b.frm.tds(width: '94%') }

end