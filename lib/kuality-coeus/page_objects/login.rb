class Login < BasePage

  page_url "#{$base_url}portal.do?"

  element(:username) { |b| b.text_field(name: '__login_user') }
  button 'Login'

end