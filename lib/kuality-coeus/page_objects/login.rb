class Login < BasePage

  page_url "#{$base_url+$context}backdoorlogin.do"
  element(:username) { |b| b.text_field(name: /login_user/) }
  element(:login_button) { |b| b.button(id: 'Rice-LoginButton') }
  action(:login) { |b| b.login_button.click }

end

class CASLogin < BasePage

  page_url "#{$base_url+$cas_context}login"
  element(:username) { |b| b.text_field(name: 'username') }
  element(:login_button) { |b| b.button(name: 'submit') }

  action(:login) { |b| b.login_button.click }

end