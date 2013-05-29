Given /^I have a (.*) percent, FY(\d+), (.*)-Campus, '(.*)' activity, (.*) type Institute Rate for unit# (.*)$/ do |rate, year, campus, activity, rate_type, unit|
  @rate = make InstituteRateObject, rate: rate,
               fiscal_year: year,
               on_off_campus_flag: campus_flag[campus],
               activity_type: activity,
               rate_type: rate_type,
               unit_number: unit
  @rate.create unless @rate.exist?
end

When /^I delete the Institute Rate$/ do
  @rate.delete
end