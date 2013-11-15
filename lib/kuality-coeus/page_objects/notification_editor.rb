class NotificationEditor < BasePage

  global_buttons
  document_header_elements

  element(:message) { |b| b.frm.text_field(name: 'notificationHelper.notification.message') }

  value(:institutional_proposal_number) { |b| b.message.text[/(?<=is )\d+/] }

end