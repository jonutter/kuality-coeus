class Login < BasePage

  page_url "#{$base_url}backdoorlogin.do"

  element(:username) { |b| b.text_field(name: /login_user/) }
  button 'Login'

end