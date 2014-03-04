class AuthExceptionReport < BasePage

  tiny_buttons

  value(:error_message) { |b| b.frm.table(class: 'container2').row[1].text }

end