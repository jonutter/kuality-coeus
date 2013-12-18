class InstitutionalProposalLookup < Lookups

  url_info 'Institutional%20Proposal','kra.institutionalproposal.home.InstitutionalProposal'

  STATUS = 4

  element(:institutional_proposal_number) { |b| b.frm.text_field(name: 'proposalNumber') }
  element(:institutional_proposal_status) { |b| b.frm.select(name: 'statusCode') }
  element(:account_id) { |b| b.frm.text_field(name: 'currentAccountNumber') }
  element(:sponsor_id) { |b| b.frm.text_field(name: 'sponsorCode') }
  element(:sponsor_name) { |b| b.frm.text_field(name: 'sponsor.sponsorName') }
  p_value(:ip_status) { |match, p| p.item_row(match)[STATUS].text }

  # This returns an array containing whatever institutional proposal
  # numbers were returned in the search...
  value(:institutional_proposal_numbers) { |b|
        array = []
        b.results_table.rows.each { |row| array << row[1].text }
        array[1..-1]
    }

end