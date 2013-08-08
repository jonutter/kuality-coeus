Then(/^the following s2s form attachment options should be present: (.*)$/) do |form_name|
  on S2S do |page|
    page.form_names.should include form_name
  end
end