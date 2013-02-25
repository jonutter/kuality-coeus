class Login < PageFactory

  page_url $base_url
  expected_title 'Login'

  element(:username) { |b| b.text_field(name: '__login_user') }
  button 'Login'

end