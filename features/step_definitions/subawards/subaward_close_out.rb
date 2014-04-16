When /^the closeout's date requested is set$/ do
  on(Subaward).date_requested.set right_now[:date_w_slashes]
  on(Subaward).date_followup.click
end

Then /^the followup date is automatically (\d+) (days|weeks) later$/ do |count, type|
  conversion = { 'days' => 1, 'weeks' => 7 }
  follow_up_date = hours_from_now(count.to_i*24*conversion[type])[:custom].strftime('%-m/%-d/%Y')
  on(Subaward).date_followup.value.should==follow_up_date
end