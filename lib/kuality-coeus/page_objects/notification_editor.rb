class NotificationEditor < BasePage

  global_buttons
  document_header_elements

  action(:employee_search) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.bo.KcPerson!!).(((personId:notificationHelper.newPersonId))).((``)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;;::::).anchor').click }
  
  action(:add) { |b| b.frm.button(name: 'methodToCall.addNotificationRecipient.anchor').click }
  element(:message) { |b| b.frm.text_field(name: 'notificationHelper.notification.message') }

  value(:institutional_proposal_number) { |b| b.message.text[/(?<=is )\d+/] }

end