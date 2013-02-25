class Permissions < ProposalDevelopmentDocument

  proposal_header_elements

  element(:user_name) { |b| b.frm.text_field(id: 'newProposalUser.username') }
  element(:role) { |b| b.frm.select(id: 'newProposalUser.roleName') }
  action(:add) { |b| b.frm.button(name: 'methodToCall.addProposalUser.anchorUsers').click }

  action(:assigned_role) { |user, b| b.user_roles_table.row(text: /#{user}/)[5].text }
  
  element(:user_roles_table) { |b| b.frm.table(id: 'user-roles') }

end