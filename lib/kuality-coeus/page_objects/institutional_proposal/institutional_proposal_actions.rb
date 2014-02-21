class InstitutionalProposalActions < KCInstitutionalProposal

  route_log
  validation_elements

  # Funded Awards
  action(:unlock_selected) { |b| b.frm.button(name: 'methodToCall.unlockSelected.anchorFundedAwards').click }
  p_element(:funded_award) { |award, b| b.target_row(award).checkbox }

  element(:funded_awards_div) { |b| b.frm.div(id: 'tab-FundedAwards-div') }
  #private :funded_awards_div
  p_element(:target_row) { |match, b| b.funded_awards_div.table.row(text: /#{match}/) }
  #private :target_row

end