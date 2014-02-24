class Login < BasePage

  page_url "#{$base_url}backdoorlogin.do"

  element(:username) { |b| b.text_field(name: /login_user/) }
  element(:login_button) { |b| b.button(id: 'Rice-LoginButton') }
  action(:login) { |b| b.login_button.click }

end