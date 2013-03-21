class Permissions < ProposalDevelopmentDocument

  proposal_header_elements
  error_messages

  element(:user_name) { |b| b.frm.text_field(id: 'newProposalUser.username') }
  element(:role) { |b| b.frm.select(id: 'newProposalUser.roleName') }
  action(:add) { |b| b.frm.button(name: 'methodToCall.addProposalUser.anchorUsers').click }

  action(:assigned_role) { |user, b| b.user_roles_table.row(text: /#{user}/)[5].text }
  action(:edit_role) { |user, b| b.user_roles_table.row(text: /#{user}/).button(name: /methodToCall.editRoles.line\d+.anchorUsers/).click }
  action(:delete) { |user, b| b.user_roles_table.row(text: /#{user}/).button(name: /methodToCall.deleteProposalUser.line\d+.anchorUsers/).click }
  
  element(:user_roles_table) { |b| b.frm.table(id: 'user-roles') }

end