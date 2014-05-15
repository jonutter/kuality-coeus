class CASLogin < BasePage

  page_url "http://test.kc.kuali.org/cas-dly/login"

  element(:username) { |b| b.frm.text_field(name: 'username') }
  element(:login_button) { |b| b.button(name: 'submit') }
  action(:login) { |b| b.login_button.click }

end