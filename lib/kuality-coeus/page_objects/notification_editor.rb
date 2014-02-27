class NotificationEditor < BasePage

  global_buttons
  document_header_elements

  action(:employee_search) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.bo.KcPerson!!).(((personId:notificationHelper.newPersonId))).((``)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;;::::).anchor').click }
  
  action(:add) { |b| b.frm.button(name: 'methodToCall.addNotificationRecipient.anchor').click }

  element(:subject) { |b| b.frm.text_field(name: 'notificationHelper.notification.subject') }
  element(:message) { |b| b.frm.text_field(name: 'notificationHelper.notification.message') }

  # Unfortunately this is necessary because it's the only way
  # to know the IP Number when it gets created
  value(:institutional_proposal_number) { |b| b.message.text[/(?<=is )\d+/] }

end